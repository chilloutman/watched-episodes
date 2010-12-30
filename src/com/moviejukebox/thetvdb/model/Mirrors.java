package com.moviejukebox.thetvdb.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.moviejukebox.thetvdb.tools.DOMHelper;

/**
 *
 * @author altman.matthew
 * @author stuart.boston
 */
public class Mirrors {

    public static String TYPE_XML = "XML";
    public static String TYPE_BANNER = "BANNER";
    public static String TYPE_ZIP = "ZIP";
    
    private static final Random RNDM = new Random();
    
    private List<String> xmlList = new ArrayList<String>();
    private List<String> bannerList = new ArrayList<String>();
    private List<String> zipList = new ArrayList<String>();
    
    public Mirrors(String apiKey) {
        // Make this synchronized so that only one 
        synchronized (this) {
            String urlString = "http://www.thetvdb.com/api/" + apiKey + "/mirrors.xml";
            Document doc = null;
            try {
                doc = DOMHelper.getEventDocFromUrl(urlString);
                int typeMask = 0;
                String url = null;
                
                NodeList nlMirror = doc.getElementsByTagName("Mirror");
                for (int nodeLoop = 0; nodeLoop < nlMirror.getLength(); nodeLoop++) {
                    Node nMirror = nlMirror.item(nodeLoop);
                    
                    if (nMirror.getNodeType() == Node.ELEMENT_NODE) {
                        Element eMirror = (Element) nMirror;
                        url = DOMHelper.getValueFromElement(eMirror, "mirrorpath");
                        typeMask = Integer.parseInt(DOMHelper.getValueFromElement(eMirror, "typemask"));
                        addMirror(typeMask, url);
                    }
                }
            } catch (Exception error) {
                System.out.println("ERROR: TheTVDB API -> " + error.getMessage());
                return;
            } catch (Throwable tw) {
                // Message is passed to us
                System.out.println("ERROR: TheTVDB API -> " + tw.getMessage());
            }
        }
    }
    
    public String getMirror(String type) {
        String url = null;
        if (type.equals(TYPE_XML) && !xmlList.isEmpty()) {
            url = xmlList.get(RNDM.nextInt(xmlList.size()));
        } else if (type.equals(TYPE_BANNER) && !bannerList.isEmpty()) {
            url = bannerList.get(RNDM.nextInt(bannerList.size()));
        } else if (type.equals(TYPE_ZIP) && !zipList.isEmpty()) {
            url = zipList.get(RNDM.nextInt(zipList.size()));
        }
        return url;
    }
    
    private void addMirror(int typeMask, String url) {
        switch (typeMask) {
            case 1: xmlList.add(url);
                    break;
            case 2: bannerList.add(url);
                    break;
            case 3: xmlList.add(url);
                    bannerList.add(url);
                    break;
            case 4: zipList.add(url);
                    break;
            case 5: xmlList.add(url);
                    zipList.add(url);
                    break;
            case 6: bannerList.add(url);
                    zipList.add(url);
                    break;
            case 7: xmlList.add(url);
                    bannerList.add(url);
                    zipList.add(url);
                    break;
        }
    }
}
