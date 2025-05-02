const invocationCounter = new Map();

// just for debugging but not precise!!
export function detectInvocationLoop(context, methodName) {
    if (invocationCounter.size > 100) {
        invocationCounter.clear();
    }
    const key = `${methodName}:${context.resource.name}`;
    const count = (invocationCounter.get(key) ?? 0) + 1;
    invocationCounter.set(key, count);
    console.warn(`[${methodName}] invoked ${count}x for ${key}`);
}
