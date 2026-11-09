@wrapMethod(NameplateVisualsLogicController)
public final func UpdateHealthbarColor(isHostile: Bool) -> Void {
    if (StatusEffectSystem.ObjectHasStatusEffect(this.m_cachedPuppet, t"BaseStatusEffect.CESecondHeartMainEffect") || StatusEffectSystem.ObjectHasStatusEffect(this.m_cachedPuppet, t"BaseStatusEffect.CE_PainEditorEffect")) {
        inkWidgetRef.SetState(this.m_healthbarWidget, n"CEImmuneColor");
        inkWidgetRef.SetState(this.m_healthBarFull, n"CEImmuneColor");
        inkWidgetRef.SetState(this.m_healthBarFrame, n"CEImmuneColor");
        inkWidgetRef.SetTintColor(this.m_healthbarWidget, new HDRColor(1.0, 1.0, 1.0, 1.0));
        inkWidgetRef.SetTintColor(this.m_healthBarFull, new HDRColor(1.0, 1.0, 1.0, 1.0));
        inkWidgetRef.SetTintColor(this.m_healthBarFrame, new HDRColor(1.0, 1.0, 1.0, 1.0));
    } else {
        wrappedMethod(isHostile);
    }
}

@wrapMethod(BossHealthBarGameController)
public final func UpdateHealthValue(newValue: Float, opt silent: Bool) -> Void {
    wrappedMethod(newValue, silent);

    let rootWidget = this.GetRootWidget() as inkCanvas;
    let bar = rootWidget.GetWidget(n"healthMain/wrapper/logic/full") as inkRectangle;

    if (StatusEffectSystem.ObjectHasStatusEffect(this.m_boss, t"BaseStatusEffect.CESecondHeartMainEffect") || StatusEffectSystem.ObjectHasStatusEffect(this.m_boss, t"BaseStatusEffect.CE_PainEditorEffect")) {
        bar.SetState(n"CEImmuneColor");
        bar.SetTintColor(new HDRColor(1.0, 1.0, 1.0, 1.0));
    } else {
        bar.SetState(n"Hostile");
        bar.SetTintColor(new HDRColor(1.176, 0.38, 0.348, 1.0));
    }
}
