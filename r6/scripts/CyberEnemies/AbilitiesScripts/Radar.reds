module CyberEnemies.Radar

@addField(NPCPuppet)
public let ce_playerTriggeredRadar: Bool = false;


@addField(NPCPuppet)
public let ce_radarCounter: Float = 0.0;

@addMethod(NPCPuppet)
public func CE_AddRadarHighlight () {
    let data: ref<FocusForcedHighlightData>;
    let highlightEvt: ref<ForceVisionApperanceEvent>;
    highlightEvt = new ForceVisionApperanceEvent();
    data = new FocusForcedHighlightData();
    data.sourceID = GetPlayer(GetGameInstance()).GetEntityID();
    data.sourceName = GetPlayer(GetGameInstance()).GetClassName();
    data.highlightType = EFocusForcedHighlightType.ENEMY_NETRUNNER;
    data.outlineType = EFocusOutlineType.HOSTILE;
    data.priority = EPriority.High;
    data.isRevealed = true;
    data.patternType = VisionModePatternType.Netrunner;
    highlightEvt.forcedHighlight = data;
    highlightEvt.apply = true;
    this.QueueEvent(highlightEvt);
}

@addMethod(NPCPuppet)
public func CE_RemoveRadarHighlight () {
    let data: ref<FocusForcedHighlightData>;
    let highlightEvt: ref<ForceVisionApperanceEvent>;
    highlightEvt = new ForceVisionApperanceEvent();
    data = new FocusForcedHighlightData();
    data.sourceID = GetPlayer(GetGameInstance()).GetEntityID();
    data.sourceName = GetPlayer(GetGameInstance()).GetClassName();
    data.highlightType = EFocusForcedHighlightType.ENEMY_NETRUNNER;
    data.outlineType = EFocusOutlineType.HOSTILE;
    data.priority = EPriority.High;
    data.isRevealed = true;
    data.patternType = VisionModePatternType.Netrunner;
    highlightEvt.forcedHighlight = data;
    highlightEvt.apply = false;
    this.QueueEvent(highlightEvt);
}

public func CE_UpdateRadarWidget(visible: Bool, value: Float, tag: Int32) {
  let inkSystem = GameInstance.GetInkSystem();
  let hudRoot = inkSystem.GetLayer(n"inkHUDLayer").GetVirtualWindow();

  if(!IsDefined(hudRoot.GetWidget(n"ceArmorWidget"))) {
    let root = new inkCanvas();
    root.SetName(n"ceArmorWidget");
    root.SetAnchor(inkEAnchor.Centered);
    root.SetAnchorPoint(0.5, 0.3);
    root.SetScale(new Vector2(0.7, 0.7));
    root.SetSize(1600, 600);
    root.SetVisible(true);
    root.Reparent(hudRoot);

    let wrapper = new inkVerticalPanel();
    wrapper.SetMargin(-58.0, 300.0, 0, 0);
    wrapper.SetName(n"1");
    wrapper.SetAnchor(inkEAnchor.Centered);
    wrapper.SetAnchorPoint(0.5, 0.5);
    wrapper.SetVisible(true);
    wrapper.Reparent(root);

    let text = new inkText();
    text.SetText(GetLocalizedTextByKey(n"cyberEnemies_radar3"));
    text.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    text.SetMargin(0, 20.0, 0, 0);
    text.SetFontSize(36);
    text.BindProperty(n"tintColor", n"MainColors.Red");
    text.BindProperty(n"fontStyle", n"MainColors.BodyFontWeight");
    text.BindProperty(n"fontSize", n"MainColors.ReadableMedium");
    text.SetFontStyle(n"Medium");
    text.SetTintColor(new HDRColor(1.0, 0.18, 0.22, 1.0));
    text.SetFitToContent(true);
    text.SetOpacity(1.0);
    text.SetVisible(true);
    text.SetName(n"nameText");
    text.Reparent(wrapper);

    let barWrapper = new inkCanvas();
    barWrapper.SetHAlign(inkEHorizontalAlign.Left);
    barWrapper.SetVAlign(inkEVerticalAlign.Top);
    barWrapper.SetSize(810.0, 12.0);
    barWrapper.SetName(n"2");
    barWrapper.Reparent(wrapper);

    let bg = new inkRectangle();
    bg.SetTintColor(new HDRColor(1.0, 0.18, 0.22, 1.0));
    bg.SetOpacity(0.2);
    bg.SetHAlign(inkEHorizontalAlign.Left);
    bg.SetVAlign(inkEVerticalAlign.Center);
    bg.SetSize(810.0, 12.0);
    bg.Reparent(barWrapper);

    let fill = new inkRectangle();
    fill.SetTintColor(new HDRColor(1.0, 0.18, 0.22, 1.0));
    fill.SetHAlign(inkEHorizontalAlign.Left);
    fill.SetVAlign(inkEVerticalAlign.Center);
    fill.SetSize(810.0, 12.0);
    fill.SetName(n"fill");
    fill.Reparent(barWrapper);

    let percentageText = new inkText();
    percentageText.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    percentageText.SetFontStyle(n"Medium");
    percentageText.SetFontSize(45);
    percentageText.SetTintColor(new HDRColor(1.0, 0.18, 0.22, 1.0));
    percentageText.SetMargin(0.0, -30.0, -5.0, 0.0);
    percentageText.SetSize(100.0, 32.0);
    percentageText.SetHAlign(inkEHorizontalAlign.Right);
    percentageText.SetVAlign(inkEVerticalAlign.Top);
    percentageText.SetAnchor(inkEAnchor.TopRight);
    percentageText.BindProperty(n"tintColor", n"MainColors.Red");
    percentageText.BindProperty(n"fontSize", n"MainColors.ReadableFontSize");
    percentageText.SetName(n"text");
    percentageText.Reparent(barWrapper);
  }

  hudRoot.GetWidget(n"ceArmorWidget").SetVisible(visible);

  if (visible) {
    hudRoot.GetWidget(n"ceArmorWidget/1/2/fill").SetSize((1.0 - value) * 810.0, 12);


    let text = tag == 0 ? GetLocalizedTextByKey(n"cyberEnemies_radar3") : GetLocalizedTextByKey(n"cyberEnemies_radar4");
    text = tag == 2 ? GetLocalizedTextByKey(n"cyberEnemies_radar5") : text;

    (hudRoot.GetWidget(n"ceArmorWidget/1/nameText") as inkText).SetText(text);
    (hudRoot.GetWidget(n"ceArmorWidget/1/2/text") as inkText).SetText(ToString(RoundMath((1.0 - value) * 100.0)) + "%");
  }
}
