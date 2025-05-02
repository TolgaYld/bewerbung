import { REGION } from "../config.js";
import { db, auth, firestore } from "../init.js";
import * as functions from "firebase-functions/v1";

export const onUserCreatedHandler =
    functions
        .region(REGION)
        .auth
        .user()
        .onCreate(async (user) => {
            const email = user.email;
            if (email == null) {
                await auth.deleteUser(user.uid);
                return null;
            }
            const companyName = email.split("@")[0];
            const inviteRef = db.doc(`invites/${companyName}`);
            const inviteSnap = await inviteRef.get();
            const inviteData = inviteSnap.data();
            if (inviteSnap.exists == false || inviteData?.isDeleted === true) {
                await auth.deleteUser(user.uid);
                return null;
            }
            const uid = user.uid;
            await db.doc(`companies/${uid}`).set({
                id: uid,
                name: companyName,
                coverLetter: null,
                logoUrl: null,
                primaryColor: null,
                secondaryColor: null,
                accentColor: null,
                contact: null,
                inviteDate: null,
                inviteDurationInMinutes: null,
                messageFromEmployee: null,
                employeeAcceptedInvite: false,
                decisionMessage: null,
                decisionStatus: "pending",
                createdAt: firestore.FieldValue.serverTimestamp(),
                updatedAt: null,
            }, { merge: true });

            await inviteRef.update({
                companyId: uid,
            });
            return null;
        });


export const onUserDeletedHandler =
    functions
        .region(REGION)
        .auth
        .user()
        .onDelete(async (user) => {
            const email = user.email;
            if (email == null) return null;
            const companyName = email.split("@")[0];
            const inviteRef = db.doc(`invites/${companyName}`);
            const inviteSnap = await inviteRef.get();
            if (inviteSnap.exists) {
                await inviteRef.update({
                    isDeleted: true,
                    updatedAt: firestore.FieldValue.serverTimestamp()
                });

                const companyRef = db.doc(`companies/${user.uid}`);
                await companyRef.delete();
            }
            return null;
        });
