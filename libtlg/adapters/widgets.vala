using Gtk;
using Gee;

namespace Tlg.Adapters.Util.Widgets {
    Box info_card(HashMap<string, string> info) {
        var result = new Box(VERTICAL, 0);
        result.add_css_class("card");
        result.hexpand = false;
        result.vexpand = false;
        result.set_margin_top(10);
        result.set_margin_bottom(10);
        result.set_margin_start(10);
        result.set_margin_end(10);
        foreach(var entry in info.entries) {
            var box = new Box(HORIZONTAL, 5);
            box.set_margin_top(10);
            box.set_margin_bottom(10);
            box.set_margin_start(10);
            box.set_margin_end(10);
            var key_label = new Label(@"<b>$(entry.key):</b>");
            key_label.set_use_markup(true);
            box.append(key_label);
            var value_label = new Label(entry.value);
            value_label.set_wrap_mode(CHAR);
            box.append(value_label);
            result.append(box);
        }
        return result;
    }
}