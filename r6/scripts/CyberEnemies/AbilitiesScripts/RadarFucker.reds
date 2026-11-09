module CyberEnemies.RadarFucker

public class RadarFuckerEvent extends Event {
  public let active: Bool;
}

@addField(MinimapContainerController) 
private let wasDisabled: Bool;


@addMethod(MinimapContainerController)
protected cb func OnRadarFuckerEvent(evt: ref<RadarFuckerEvent>) -> Void {
    if (NotEquals(evt.active, this.wasDisabled)) {
        
        this.wasDisabled = evt.active;
        let root = this.GetRootCompoundWidget();
        let container = root.GetWidget(n"MiniMapContainer") as inkCanvas;

        if (this.wasDisabled) {
            container.GetWidget(n"fluff").SetVisible(false);
            container.GetWidget(n"Loading").SetVisible(false);
            container.GetWidget(n"unmaskedContainer").SetVisible(false);
            container.GetWidget(n"zoneVignette").SetVisible(false);
            container.GetWidget(n"playerIconsHolder").SetVisible(false);
            container.GetWidget(n"combatBorderHighlight").SetScale(new Vector2(0.0, 0.0));
            container.GetWidget(n"autoDriveBorderHighlight").SetVisible(false);
            container.GetWidget(n"bg_dots").SetVisible(false);
            container.GetWidget(n"signallostContainer").SetOpacity(1.0);
            container.GetWidget(n"maskedContainer").SetVisible(false);
            container.GetWidget(n"bgColorFiller").SetVisible(false);
            
        } else {
            container.GetWidget(n"fluff").SetVisible(true);
            container.GetWidget(n"Loading").SetVisible(true);
            container.GetWidget(n"unmaskedContainer").SetVisible(true);
            container.GetWidget(n"zoneVignette").SetVisible(true);
            container.GetWidget(n"playerIconsHolder").SetVisible(true);
            container.GetWidget(n"combatBorderHighlight").SetScale(new Vector2(1.0, 1.0));
            container.GetWidget(n"autoDriveBorderHighlight").SetVisible(true);
            container.GetWidget(n"bg_dots").SetVisible(true);
            container.GetWidget(n"signallostContainer").SetOpacity(0);
            container.GetWidget(n"maskedContainer").SetVisible(true);
            container.GetWidget(n"bgColorFiller").SetVisible(true);
        }
    }
}