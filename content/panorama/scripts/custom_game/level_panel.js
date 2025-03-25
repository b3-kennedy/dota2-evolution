function OnUpdateWorldPanelText(data) {
    var label = $.GetContextPanel().GetParent().Children()
    $.Msg(data.id)
    $.Msg(label.id)
    if (label) {
        label.text = data.new_text;
    }
}

(function () {
    GameEvents.Subscribe("update_world_panel_text", OnUpdateWorldPanelText);
})();