package com.assetLiability

class AssetLiabilityService {

    def getAssetLiabilityList() {
		StringBuffer assetLiabilityXML = new StringBuffer();
		assetLiabilityXML.append("\t<assetLiabilities>\n");
		AssetLiability.list().each {assetLiabilityListItem->
			assetLiabilityXML.append("\t\t<assetLiability>\n")
			assetLiabilityXML.append("\t\t\t<id>${assetLiabilityListItem.id}</id>\n");
			assetLiabilityXML.append("\t\t\t<name>${assetLiabilityListItem.name}</name>\n");
			assetLiabilityXML.append("\t\t</assetLiability>\n")
		}
		assetLiabilityXML.append("\t</assetLiabilities>\n");
		return assetLiabilityXML.toString()
    }
}
