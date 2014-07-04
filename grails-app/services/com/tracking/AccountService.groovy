package com.tracking

class AccountService {

    def getAccountList(boolean fullXML) {
		StringBuffer accountXML = new StringBuffer();
		if (fullXML) accountXML.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
		accountXML.append("<accounts> \n");
		Account.list().each {accountListItem->
			accountXML.append("\t<account> \n")
			accountXML.append("\t\t<id>${accountListItem.id}</id> \n");
			accountXML.append("\t\t<name>${accountListItem.name}</name> \n");
			accountXML.append("\t</account> \n")
		}
		accountXML.append("</accounts>\n");
		return accountXML.toString()
    }
}
