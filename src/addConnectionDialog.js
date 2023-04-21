import GObject from "gi://GObject";
import Gtk from "gi://Gtk";
import Adw from "gi://Adw";
import Tlg from 'gi://Tlg';

export class AddConnectionDialog extends Adw.Window {
    constructor(mainWindow) {
        super({ transient_for: mainWindow, modal: true });

        this.validateInput();
    }

    static {
        GObject.registerClass({
            GTypeName: 'TrilogyAddConnectionDialog',
            Properties: {
                "valid": GObject.ParamSpec.boolean(
                    "valid",
                    "Valid",
                    "Whether the input is valid",
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    false
                )
            },
            Signals: {
                'add-connection': {
                    param_types: [Tlg.Connection]
                }
            },
            Template:  "resource:///com/rutins/Trilogy/addConnectionDialog.ui",
            InternalChildren: ["nameEntry", "urlEntry"]
        }, this);
    }

    get valid() {
        return this._valid ?? false;
    }

    set valid(value) {
        if(this._valid == value)
            return;

        this._valid = value;
        this.notify('valid');
    }

    cancelClicked() {
        this.close();
    }

    addClicked() {
        this.emit('add-connection', new Tlg.Connection({
            name: this._nameEntry.get_text(),
            url: this._urlEntry.get_text()
        }));
        this.close();
    }

    validateInput() {
        const name = this._nameEntry.get_text();
        const url = this._urlEntry.get_text();
        let failed = false;
        if(name.includes(' ') || !name) {
            failed = true;
            this._nameEntry.add_css_class("error");
        } else {
            this._nameEntry.remove_css_class("error");
        }

        if(!url.startsWith('postgresql://') || !url) {
            failed = true;
            this._urlEntry.add_css_class("error");
        } else {
            this._urlEntry.remove_css_class("error");
        }

        this.valid = !failed;
    }
}
