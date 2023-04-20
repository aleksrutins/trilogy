import GObject from 'gi://GObject'
import Json from 'gi://Json'

import Tlg from 'gi://Tlg'

export class Connection extends GObject.Object {
    static {
        GObject.registerClass({
            Properties: {
                'name': GObject.ParamSpec.string(
                    'name',
                    'Name',
                    'The name of the connection',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    null
                ),
                'url': GObject.ParamSpec.string(
                    'url',
                    'URL',
                    'The URL of the connection',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    null
                ),
                'prettyType': GObject.ParamSpec.string(
                    'prettyType',
                    'Pretty Type',
                    'The human-readable database type',
                    GObject.ParamFlags.READABLE,
                    null
                )
            },
            Implements: [Json.Serializable]
        }, this);
    }

    get name() {
        return this._name ?? null;
    }

    set name(newName) {
        if(this._name == newName) return;
        this._name = newName;
        this.notify('name');
    }

    get url() {
        return this._url ?? null;
    }

    set url(newURL) {
        if(this._url == newURL) return;
        this._url = newURL;
        this.notify('url');
        this.notify('prettyType');
    }

    get prettyType() {
        const method = this._url.split('://')[0];
        return (method == 'postgresql' ? 'PostgreSQL' : 'Unknown Type');
    }

    vfunc_find_property(name) {
        if(['prettyType'].includes(name)) return null;
        else {
            return Tlg.reflect_find_type_property(Connection, name);
        }
    }
}
