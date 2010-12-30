package com.moviejukebox.thetvdb.tools;

import java.security.PrivilegedAction;
import java.util.logging.LogRecord;

public class LogFormatter extends java.util.logging.Formatter 
{
    private static String API_KEY = null;
    private static String EOL = (String)java.security.AccessController.doPrivileged(new PrivilegedAction<Object>() {
        public Object run() {
            return System.getProperty("line.separator");
        }
    });

    public synchronized String format(LogRecord logRecord) {
        String logMessage = logRecord.getMessage();

        if (logMessage == null) {
            return "";
        }

        if (API_KEY != null) {
            logMessage = "[TheTVDB API] " + logMessage.replace(API_KEY, "[APIKEY]") + EOL;
        }
        
        Throwable thrown = logRecord.getThrown();
        if (thrown != null) { 
            logMessage = logMessage + thrown.toString(); 
        }
        return logMessage;
    }
    
    public void addApiKey(String apiKey) {
        API_KEY = apiKey; 
        return;
    }
}
