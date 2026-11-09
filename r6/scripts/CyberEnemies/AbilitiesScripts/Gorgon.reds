@wrapMethod(TimeDilationFocusModeDecisions)
protected final const func EnterCondition(const stateContext: ref<StateContext>, const scriptInterface: ref<StateGameScriptInterface>) -> Bool {
    let game = GetGameInstance();
    let player = GetPlayer(game);

    if (StatusEffectSystem.ObjectHasStatusEffect(player, t"BaseStatusEffect.CE_GorgonNPCEffect")) {
        return false;
    } else {
        return wrappedMethod(stateContext, scriptInterface);
    }

}

// wip todo - add maybe some sound effet? maybe shadow around (drug effect), and maybe v pain sounds?