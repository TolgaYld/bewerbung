import { REGION } from "../config.js";
import { detectInvocationLoop } from "../utils/logger.js";

import * as functions from "firebase-functions/v1";
import { db, firestore } from "../init.js";


export const onInviteCreateHandler =
    functions
        .region(REGION)
        .firestore
        .document("invites/{companyName}")
        .onCreate((snap) => {
            return snap.ref.set({
                companyId: null,
                isDeleted: false,
                decisionStatus: "pending",
                decisionMessage: null,
                createdAt: firestore.FieldValue.serverTimestamp(),
                updatedAt: null,
                invitingTimestamp: null,
                inviteDurationInMinutes: null,
                employeeAcceptedInvite: null,
                messageFromEmployee: null
            }, { merge: true });
        });


export const onCompanyDecisionChangeHandler =
    functions
        .region(REGION)
        .firestore
        .document("companies/{companyId}")
        .onUpdate(async (change, context) => {
            detectInvocationLoop(context, 'onCompanyDecisionChangeHandler');
            const afterData = change.after.data();
            const beforeStatus = change.before.data().decisionStatus;
            const afterStatus = afterData.decisionStatus;

            if (beforeStatus === afterStatus) return null;

            const companyName = afterData.name.toLowerCase();

            const updateData = {
                updatedAt: firestore.FieldValue.serverTimestamp()
            };
            if (afterStatus === "pending" || afterStatus === null) {
                updateData.decisionStatus = "pending";
                updateData.decisionMessage = null;
                updateData.invitingTimestamp = null;
                updateData.inviteDurationInMinutes = null;
                updateData.employeeAcceptedInvite = null;
                updateData.messageFromEmployee = null;
            } else {
                updateData.decisionStatus = afterStatus;
                updateData.decisionMessage = afterData.decisionMessage;
                updateData.invitingTimestamp = afterData.inviteDate;
                updateData.inviteDurationInMinutes = afterData.inviteDurationInMinutes;
                updateData.employeeAcceptedInvite = afterData.employeeAcceptedInvite;
                updateData.messageFromEmployee = afterData.messageFromEmployee;
            }
            const inviteSnap = await db.doc(`invites/${companyName}`).get();
            const currentData = inviteSnap.data();
            const noChange = (
                currentData?.decisionStatus === updateData.decisionStatus &&
                currentData?.decisionMessage === updateData.decisionMessage &&
                currentData?.invitingTimestamp?.toMillis?.() === updateData.invitingTimestamp?.toMillis?.() &&
                currentData?.inviteDurationInMinutes === updateData.inviteDurationInMinutes &&
                currentData?.employeeAcceptedInvite === updateData.employeeAcceptedInvite &&
                currentData?.messageFromEmployee === updateData.messageFromEmployee
            );
            if (noChange) return null;
            await db.doc(`invites/${companyName}`).update(updateData);
            return null;
        });


export const onInviteChangeHandler =
    functions
        .region(REGION)
        .firestore
        .document("invites/{companyName}")
        .onUpdate(async (change, context) => {
            detectInvocationLoop(context, 'onInviteChangeHandler');
            const beforeData = change.before.data();
            const afterData = change.after.data();
            const messageChanged = beforeData.messageFromEmployee !== afterData.messageFromEmployee;
            const acceptedChanged = beforeData.employeeAcceptedInvite !== afterData.employeeAcceptedInvite;

            if (messageChanged == false && acceptedChanged === false) {
                return null;
            }

            if (afterData.companyId == null) {
                return null;
            }
            const companyId = afterData.companyId;
            const companyRef = db.doc(`companies/${companyId}`);
            const companySnap = await companyRef.get();
            const companyData = companySnap.data();

            if (companyData.messageFromEmployee === afterData.messageFromEmployee &&
                companyData.employeeAcceptedInvite === afterData.employeeAcceptedInvite) {
                return null;
            }

            if (afterData.decisionStatus === "pending" || companyData.decisionStatus === "pending") {
                return null;
            }
            const updateData = {
                updatedAt: firestore.FieldValue.serverTimestamp()
            };
            if (messageChanged) {
                updateData.messageFromEmployee = afterData.messageFromEmployee;
            }
            if (acceptedChanged) {
                updateData.employeeAcceptedInvite = afterData.employeeAcceptedInvite;
            }
            await companyRef.update(updateData);

            return null;
        });