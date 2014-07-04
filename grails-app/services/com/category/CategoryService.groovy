package com.category

class CategoryService {

    def getCategoryList(boolean fullXML) {
		StringBuffer categoryXML = new StringBuffer();
		
		
		if (fullXML) categoryXML.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
		categoryXML.append("<categories>\n");
		
		List categoryList = Category.findAllByDisplayOnMobile("Y");
		
		categoryList.each {categoryListItem->
			categoryXML.append("\t<category>\n")
			categoryXML.append("\t\t<id>${categoryListItem.id}</id>\n");
			categoryXML.append("\t\t<name>${categoryListItem.name}</name>\n");
			categoryXML.append("\t</category>\n")
		}
		categoryXML.append("</categories>\n");
		return categoryXML.toString()
    }
}
