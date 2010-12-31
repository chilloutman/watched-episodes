/*
 *      Copyright (c) 2004-2010 YAMJ Members
 *      http://code.google.com/p/moviejukebox/people/list 
 *  
 *      Web: http://code.google.com/p/moviejukebox/
 *  
 *      This software is licensed under a Creative Commons License
 *      See this page: http://code.google.com/p/moviejukebox/wiki/License
 *  
 *      For any reuse or distribution, you must make clear to others the 
 *      license terms of this work.  
 */

package com.moviejukebox.thetvdb.tools;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.moviejukebox.thetvdb.TheTVDB;
import com.moviejukebox.thetvdb.model.Actor;
import com.moviejukebox.thetvdb.model.Banner;
import com.moviejukebox.thetvdb.model.Banners;
import com.moviejukebox.thetvdb.model.Episode;
import com.moviejukebox.thetvdb.model.Series;

public class TvdbParser {
    private static Logger logger = TheTVDB.getLogger();

    private static Series parseNextSeries(Element eSeries) throws Throwable {
        String bannerMirror = TheTVDB.getBannerMirror();
        
        Series series = new Series();
        String artwork;
        
        series.setId(DOMHelper.getValueFromElement(eSeries, "id"));
        series.setActors(parseList(DOMHelper.getValueFromElement(eSeries, "Actors"),"|,"));
        series.setAirsDayOfWeek(DOMHelper.getValueFromElement(eSeries, "Airs_DayOfWeek"));
        series.setAirsTime(DOMHelper.getValueFromElement(eSeries, "Airs_Time"));
        series.setContentRating(DOMHelper.getValueFromElement(eSeries, "ContentRating"));
        series.setFirstAired(DOMHelper.getValueFromElement(eSeries, "FirstAired"));
        series.setGenres(parseList(DOMHelper.getValueFromElement(eSeries, "Genre"), "|,"));
        series.setImdbId(DOMHelper.getValueFromElement(eSeries, "IMDB_ID"));
        series.setLanguage(DOMHelper.getValueFromElement(eSeries, "language"));
        series.setNetwork(DOMHelper.getValueFromElement(eSeries, "Network"));
        series.setOverview(DOMHelper.getValueFromElement(eSeries, "Overview"));
        series.setRating(DOMHelper.getValueFromElement(eSeries, "Rating"));
        series.setRuntime(DOMHelper.getValueFromElement(eSeries, "Runtime"));
        series.setSeriesId(DOMHelper.getValueFromElement(eSeries, "SeriesID"));
        series.setSeriesName(DOMHelper.getValueFromElement(eSeries, "SeriesName"));
        series.setStatus(DOMHelper.getValueFromElement(eSeries, "Status"));
        
        artwork = DOMHelper.getValueFromElement(eSeries, "banner");
        if (!artwork.isEmpty()) {
            series.setBanner(bannerMirror + artwork);
        }
        
        artwork = DOMHelper.getValueFromElement(eSeries, "fanart");
        if (!artwork.isEmpty()) {
            series.setFanart(bannerMirror + artwork);
        }
        
        artwork = DOMHelper.getValueFromElement(eSeries, "poster");
        if (!artwork.isEmpty()) {
            series.setPoster(bannerMirror + artwork);
        }
                
        series.setLastUpdated(DOMHelper.getValueFromElement(eSeries, "lastupdated"));
        series.setZap2ItId(DOMHelper.getValueFromElement(eSeries, "zap2it_id"));

        return series;
    }
    
    private static Banner parseNextBanner(Element eBanner) throws Throwable {
        String bannerMirror = TheTVDB.getBannerMirror();
        Banner banner = new Banner();
        String artwork;
        
        artwork = DOMHelper.getValueFromElement(eBanner, "BannerPath");
        if (!artwork.isEmpty()) {
            banner.setUrl(bannerMirror + artwork);
        }
        
        artwork = DOMHelper.getValueFromElement(eBanner, "VignettePath");
        if (!artwork.isEmpty()) {
            banner.setVignette(bannerMirror + artwork);
        }
        
        artwork = DOMHelper.getValueFromElement(eBanner, "ThumbnailPath");
        if (!artwork.isEmpty()) {
            banner.setThumb(bannerMirror + artwork);
        }
        
        banner.setBannerType(DOMHelper.getValueFromElement(eBanner, "BannerType"));
        banner.setBannerType2(DOMHelper.getValueFromElement(eBanner, "BannerType2"));
        banner.setLanguage(DOMHelper.getValueFromElement(eBanner, "Language"));
        banner.setSeason(DOMHelper.getValueFromElement(eBanner, "Season"));
        
        return banner;
    }

    /**
     * Get the episode information from the URL
     * @param urlString
     * @return
     */
    public static Episode getEpisode(String urlString) {
        Episode episode = null;
        Document doc;
        
        try {
            doc = DOMHelper.getEventDocFromUrl(urlString);
            episode = parseNextEpisode(doc);
        } catch (Exception error) {
            logger.warning(parseErrorMessage(error.getMessage()));
        } catch (Throwable tw) {
            // Message is passed to us
            logger.warning(tw.getMessage());
        }
        return episode;
    }

    /**
     * Parse the document for episode information
     * @param doc
     * @return
     * @throws Throwable 
     */
    private static Episode parseNextEpisode(Document doc) throws Throwable {
        Episode episode = null;
        NodeList nlEpisode;
        Node nEpisode;
        Element eEpisode;
        
        nlEpisode = doc.getElementsByTagName("Episode");
        
        for (int loop = 0; loop < nlEpisode.getLength(); loop++) {
            nEpisode = nlEpisode.item(loop);
            
            if (nEpisode.getNodeType() == Node.ELEMENT_NODE) {
                episode = new Episode();
                eEpisode = (Element) nEpisode;
                
                episode.setId(DOMHelper.getValueFromElement(eEpisode, "id"));
                episode.setCombinedEpisodeNumber(DOMHelper.getValueFromElement(eEpisode, "Combined_episodenumber"));
                episode.setCombinedSeason(DOMHelper.getValueFromElement(eEpisode, "Combined_season"));
                episode.setDvdChapter(DOMHelper.getValueFromElement(eEpisode, "DVD_chapter"));
                episode.setDvdDiscId(DOMHelper.getValueFromElement(eEpisode, "DVD_discid"));
                episode.setDvdEpisodeNumber(DOMHelper.getValueFromElement(eEpisode, "DVD_episodenumber"));
                episode.setDvdSeason(DOMHelper.getValueFromElement(eEpisode, "DVD_season"));
                episode.setDirectors(parseList(DOMHelper.getValueFromElement(eEpisode, "Director"), "|,"));
                episode.setEpImgFlag(DOMHelper.getValueFromElement(eEpisode, "EpImgFlag"));
                episode.setEpisodeName(DOMHelper.getValueFromElement(eEpisode, "EpisodeName"));
                try {
                    episode.setEpisodeNumber(Integer.parseInt(DOMHelper.getValueFromElement(eEpisode, "EpisodeNumber")));
                } catch (Exception ignore) {
                    episode.setEpisodeNumber(0);
                }
                episode.setFirstAired(DOMHelper.getValueFromElement(eEpisode, "FirstAired"));
                episode.setGuestStars(parseList(DOMHelper.getValueFromElement(eEpisode, "GuestStars"), "|,"));
                episode.setImdbId(DOMHelper.getValueFromElement(eEpisode, "IMDB_ID"));
                episode.setLanguage(DOMHelper.getValueFromElement(eEpisode, "Language"));
                episode.setOverview(DOMHelper.getValueFromElement(eEpisode, "Overview"));
                episode.setProductionCode(DOMHelper.getValueFromElement(eEpisode, "ProductionCode"));
                episode.setRating(DOMHelper.getValueFromElement(eEpisode, "Rating"));
                try {
                    episode.setSeasonNumber(Integer.parseInt(DOMHelper.getValueFromElement(eEpisode, "SeasonNumber")));
                } catch (Exception ignore) {
                    episode.setSeasonNumber(0);
                }
                episode.setWriters(parseList(DOMHelper.getValueFromElement(eEpisode, "Writer"), "|,"));
                episode.setAbsoluteNumber(DOMHelper.getValueFromElement(eEpisode, "absolute_number"));
                String s = DOMHelper.getValueFromElement(eEpisode, "filename");
                if (!s.isEmpty()) {
                    episode.setFilename(TheTVDB.getBannerMirror() + s);
                }
                episode.setLastUpdated(DOMHelper.getValueFromElement(eEpisode, "lastupdated"));
                episode.setSeasonId(DOMHelper.getValueFromElement(eEpisode, "seasonid"));
                episode.setSeriesId(DOMHelper.getValueFromElement(eEpisode, "seriesid"));

                try {
                    episode.setAirsAfterSeason(Integer.parseInt(DOMHelper.getValueFromElement(eEpisode, "airsafter_season")));
                } catch (Exception ignore) {
                    episode.setAirsAfterSeason(0);
                }
                
                try {
                    episode.setAirsBeforeEpisode(Integer.parseInt(DOMHelper.getValueFromElement(eEpisode, "airsbefore_episode")));
                } catch (Exception ignore) {
                    episode.setAirsBeforeEpisode(0);
                }

                try {
                    episode.setAirsBeforeSeason(Integer.parseInt(DOMHelper.getValueFromElement(eEpisode, "airsbefore_season")));
                } catch (Exception ignore) {
                    episode.setAirsBeforeSeason(0);
}
                break;  // We only want the first episode
            }     
        }
        return episode;
    }

    /**
     * Create a List from a delimited string
     * @param input
     * @param delim
     * @return
     */
    private static List<String> parseList(String input, String delim) {
        List<String> result = new ArrayList<String>();
        
        StringTokenizer st = new StringTokenizer(input, delim);
        while (st.hasMoreTokens()) {
            String token = st.nextToken().trim();
            if (token.length() > 0) {
                result.add(token);
            }
        }
        
        return result;
    }

    /**
     * Get a list of series from the url
     * @param urlString
     * @return
     */
    public static List<Series> getSeriesList(String urlString) {
        List<Series> seriesList = new ArrayList<Series>();
        Series series = null;
        NodeList nlSeries;
        Node nSeries;
        Element eSeries;
        
        try {
            Document doc = DOMHelper.getEventDocFromUrl(urlString);
            nlSeries = doc.getElementsByTagName("Series");
            for (int loop = 0; loop < nlSeries.getLength(); loop++) {
                nSeries = nlSeries.item(loop);
                if (nSeries.getNodeType() == Node.ELEMENT_NODE) {
                    eSeries = (Element) nSeries;
                    series = parseNextSeries(eSeries);
                    if (series != null) {
                        seriesList.add(series);
                    }
                }
            }
        } catch (Exception error) {
            logger.warning("Series error: " + error.getMessage());
        } catch (Throwable tw) {
            // Message is passed to us
            logger.warning(tw.getMessage());
        }
        
        return seriesList;
    }
    
    /**
     * Get a list of the actors from the url
     * @param urlString
     * @return
     */
    public static List<Actor> getActors(String urlString) {
        List<Actor> results = new ArrayList<Actor>();
        Actor actor = null;
        Document doc;
        NodeList nlActor;
        Node nActor;
        Element eActor;
        
        try {
            doc = DOMHelper.getEventDocFromUrl(urlString);
    
            nlActor = doc.getElementsByTagName("Actor");
            
            for (int loop = 0; loop < nlActor.getLength(); loop++) {
                nActor = nlActor.item(loop);
                
                if (nActor.getNodeType() == Node.ELEMENT_NODE) {
                    eActor = (Element) nActor;
                    actor = new Actor();
                
                    actor.setId(DOMHelper.getValueFromElement(eActor, "id"));
                    String image = DOMHelper.getValueFromElement(eActor, "Image");
                    if (!image.isEmpty()) {
                        actor.setImage(TheTVDB.getBannerMirror() + image);                    
                    }
                    actor.setName(DOMHelper.getValueFromElement(eActor, "Name"));
                    actor.setRole(DOMHelper.getValueFromElement(eActor, "Role"));
                    actor.setSortOrder(DOMHelper.getValueFromElement(eActor, "SortOrder"));
                    
                    results.add(actor);
                }
            }
        } catch (Exception error) {
            logger.warning("Actors error: " + error.getMessage());
        } catch (Throwable tw) {
            // Message is passed to us
            logger.warning(tw.getMessage());
        }
        
        Collections.sort(results);
        return results;
    }

    /**
     * Get a list of banners from the URL
     * @param urlString
     * @return
     */
    public static Banners getBanners(String urlString) {
        Banners banners = new Banners();
        Banner banner = null;
        
        NodeList nlBanners;
        Node nBanner;
        Element eBanner;
        
        try {
            Document doc = DOMHelper.getEventDocFromUrl(urlString);
            
            nlBanners = doc.getElementsByTagName("Banner");
            for (int loop = 0; loop < nlBanners.getLength(); loop++) {
                nBanner = nlBanners.item(loop);
                if (nBanner.getNodeType() == Node.ELEMENT_NODE) {
                    eBanner = (Element) nBanner;
                    banner = parseNextBanner(eBanner);
                    if (banner != null) {
                        banners.addBanner(banner);
                    }
                }
            }
        } catch (Exception error) {
            logger.warning("Banners error: " + error.getMessage());
        } catch (Throwable tw) {
            // Message is passed to us
            logger.warning(tw.getMessage());
        }
        
        return banners;
    }

    /**
     * Parse the error message to return a more user friendly message
     * @param errorMessage
     * @return
     */
    public static String parseErrorMessage(String errorMessage) {
        String response = "";
        
        Pattern pattern = Pattern.compile(".*?/series/(\\d*?)/default/(\\d*?)/(\\d*?)/.*?");
        Matcher matcher = pattern.matcher(errorMessage);
        
        // See if the error message matches the pattern and therefore we can decode it
        if (matcher.find() && matcher.groupCount() == 3) {
            int seriesId = Integer.parseInt(matcher.group(1));
            int seasonId = Integer.parseInt(matcher.group(2));
            int episodeId = Integer.parseInt(matcher.group(3));
            
            response = "Series Id: " + seriesId + ", Season: " + seasonId + ", Episode: " + episodeId + ": ";
            
            if (episodeId == 0) {
                // We should probably try an scrape season 0/episode 1
                response += "Episode seems to be a misnamed pilot episode.";
            } else if (episodeId > 24) {
                response += "Episode number seems to be too large.";
            } else if (seasonId == 0 && episodeId > 1) {
                response += "This special episode does not exist.";
            } else if (errorMessage.toLowerCase().contains("content is not allowed in prolog")) {
                response += "Unable to retrieve episode information from TheTVDb, try again later.";
            } else {
                response += "Unknown episode error: " + errorMessage;
            }
        } else {
            // Don't recognise the error format, so just return it
            if (errorMessage.toLowerCase().contains("content is not allowed in prolog")) {
                response = "Unable to retrieve episode information from TheTVDb, try again later.";
            } else {
                response = "Episode error: " + errorMessage;
            }
        }
        
        return response;
    }
    
}
