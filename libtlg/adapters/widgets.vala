using Gtk;
using Gee;

namespace Tlg.Adapters.Util.Widgets {
    Label label(string text) {
        var result = new Label(text);
        result.set_use_markup(true);
        return result;
    }
    Box box_v(Orientation orientation, va_list args) {
        var result = new Box(orientation, 6);
        Widget? obj;
        while((obj = args.arg()) != null) {
            result.append(obj);
        }
        return result;
    }
    Box box(Orientation orientation, ...) {
        return box_v(orientation, va_list());
    }
    Box titled_section_v(string title, Orientation orientation, va_list args) {
        var result = box(VERTICAL, 
            label(@"<span size='x-large'>$(title)</span>"),
            box_v(orientation, args));
        result.add_css_class("card");
        result.hexpand = false;
        result.vexpand = false;
        result.set_margin_top(10);
        result.set_margin_bottom(10);
        result.set_margin_start(10);
        result.set_margin_end(10);
        return result;
    } 
    Box titled_section(string title, Orientation orientation, ...) {
        return titled_section_v(title, orientation, va_list());
    }
    Box info_card(string title, ...) {
        var result = titled_section(title, VERTICAL);

        var args = va_list();
        var map = new HashMap<string, string>();
        string? prev_arg = null;
        string? arg = null;
        int i = 0;
        while((arg = args.arg()) != null) {
            if(i % 2 == 1) {
                map.set(prev_arg ?? "", arg);
            }
            prev_arg = arg;
            i++;
        }

        foreach(var entry in map) {
            var box = new Box(HORIZONTAL, 5);
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