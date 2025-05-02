import { onUserCreatedHandler, onUserDeletedHandler } from "./handlers/auth.js";
import { onInviteCreateHandler, onCompanyDecisionChangeHandler, onInviteChangeHandler } from "./handlers/invite.js";

export const onUserCreated = onUserCreatedHandler;
export const onUserDeleted = onUserDeletedHandler;

export const onInviteCreated = onInviteCreateHandler;
export const onCompanyDecisionChange = onCompanyDecisionChangeHandler;
export const onInviteChange = onInviteChangeHandler;