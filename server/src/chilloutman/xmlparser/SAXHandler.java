package chilloutman.xmlparser;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public abstract class SAXHandler<ResultType> extends DefaultHandler {
	private ResultType result;
	private String currentParentElement;
	private String currentChildElement;
	private StringBuilder currentValue;
	
	public ResultType getResult () {
		return result;
	}
	
	@Override
	public void startDocument () throws SAXException {
		result= getNewResult();
		currentParentElement= null;
		currentChildElement= null;
		currentValue= new StringBuilder();
	}
	
	protected abstract ResultType getNewResult () throws SAXException;
	
	@Override
	public void startElement (String uri, String localName, String qName, Attributes atts) throws SAXException {
		if (isRelevantParentElement(qName) && (currentParentElement != qName)) {
			willStartParentElement(qName);
			currentParentElement= qName;
		} else if (currentParentElement != null) {
			currentChildElement= (isRelevantChildElement(currentParentElement, qName)) ? qName : null;
		}
	}
	
	protected abstract boolean isRelevantParentElement (String elementName) throws SAXException;
	protected abstract boolean isRelevantChildElement (String parentName, String elementName) throws SAXException;
	protected abstract void willStartParentElement (String parentName) throws SAXException;
	
	@Override
	public void characters (char[] ch, int start, int length) throws SAXException {
		if (currentChildElement != null) {
			String content= new String(ch).substring(start, start + length);
			currentValue.append(content);
		}
	}
	
	@Override
	public void endElement (String uri, String localName, String qName) throws SAXException {
		if (currentChildElement != null) {
			XMLElement element= new XMLElement();
			element.setName(currentChildElement);
			element.setParentName(currentParentElement);
			element.setContent(currentValue.toString().trim());
			currentValue.delete(0, currentValue.length());
			currentChildElement= null;
			
			parseChildElement(element);
		} else if (qName == currentParentElement) {
			finishedParentElement(currentParentElement);
			currentParentElement= null;
		}
	}
	
	protected abstract void parseChildElement (XMLElement element) throws SAXException;
	protected abstract void finishedParentElement (String parentName) throws SAXException;
	
	@Override
	public void endDocument () throws SAXException {
		parsingEnded();
	}
	
	protected abstract void parsingEnded () throws SAXException;
}
