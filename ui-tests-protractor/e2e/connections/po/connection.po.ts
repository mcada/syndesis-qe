import { element, by, ElementFinder, ElementArrayFinder } from 'protractor';
import { P } from '../../common/world';
import { ConnectionsListComponent } from '../list/list.po';

/**
 * Created by mcada on 7.11.17.
 */
export class ConnectionObjectElement {

    connectionElement(connectionName: string): ElementFinder {
        const connectionsListComp = new ConnectionsListComponent();
        return connectionsListComp.getConnection(connectionName);
    }

    public getKebabMenuButtons(connectionName: string) : ElementArrayFinder {
        return this.connectionElement(connectionName).all(by.css('button.btn.btn-link.dropdown-toggle'))
    }

    public async clickKebabMenuButton(button: string, connectionName: string) : P<any> {
        let conObj = this.connectionElement(connectionName);
        await conObj.element(by.id('dropdownKebabRight9')).click();
        return conObj.element(by.xpath(`.//*[.="${button}"]`)).click();        
    }


}
