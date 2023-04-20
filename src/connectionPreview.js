import GObject from 'gi://GObject';
import { Connection } from './connection.js';

export class ConnectionPreview extends GObject.Object {
    static {
        GObject.registerClass({
            GTypeName: "TrilogyConnectionPreview",
            Properties: {
                'connection': GObject.ParamSpec.object(
                    'connection',
                    'Connection',
                    'The connection to preview',
                    Connection.$gtype,
                    GObject.ParamFlags.READWRITE
                )
            },
            Template: "resource://com/rutins/Trilogy/connectionPreview.ui"
        }, this)
    }

    constructor(conn) {
        super({ 'connection': conn });
    }
}
