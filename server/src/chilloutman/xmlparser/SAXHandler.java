package chilloutman.xmlparser;

import java.util.Stack;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public abstract class SAXHandler<ResultType> extends DefaultHandler {
	private ResultType result;
	private Stack<XMLElement> elementStack;
	private StringBuilder currentValue;
	long startTime;
	
	public ResultType getResult () {
		return result;
	}
	
	@Override
	public void startDocument () throws SAXException {
		startTime = System.currentTimeMillis();
		result = getNewResult();
		elementStack = new Stack<XMLElement>();
		currentValue = new StringBuilder();
	}
	
	protected abstract ResultType getNewResult () throws SAXException;
	
	@Override
	public void startElement (String uri, String localName, String qName, Attributes atts) throws SAXException {
		willStartElement(qName);
		XMLElement element = new XMLElement();
		element.setName(qName);
		elementStack.push(element);
	}
	
	protected abstract void willStartElement (String elementName) throws SAXException;
	
	@Override
	public void characters (char[] ch, int start, int length) throws SAXException {
		if (!elementStack.empty()) {
			String content = new String(ch).substring(start, start + length);
			currentValue.append(content);
		} else {
			System.err.println("XML-element named \"" + elementStack.peek().getName() + "\" has no content!");
		}
	}
	
	@Override
	public void endElement (String uri, String localName, String qName) throws SAXException {
		XMLElement element = elementStack.pop();
		element.setContent(currentValue.toString().trim());
		currentValue.delete(0, currentValue.length());
		
		if (!elementStack.empty()) {
			element.setParentName(elementStack.peek().getName());
		}
		
		parseElement(element);
		finishedElement(element.getName());
	}
	
	protected abstract void parseElement (XMLElement element) throws SAXException;
	protected abstract void finishedElement (String elementName) throws SAXException;
	
	@Override
	public void endDocument () throws SAXException {
		parsingEnded();
		System.out.println("Parsing time: " + (System.currentTimeMillis() - startTime) +" ms");
	}
	
	protected abstract void parsingEnded () throws SAXException;
}
