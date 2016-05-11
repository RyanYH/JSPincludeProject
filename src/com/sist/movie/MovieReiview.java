package com.sist.movie;
/*

 */
import java.io.*;
import java.net.*;
import java.util.*;

import org.json.simple.*;
import org.json.simple.parser.JSONParser;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.Rserve.RConnection;

import javafx.util.Pair;

public class MovieReiview {

	public static void main(String[] args){
		Scanner scan = new Scanner(System.in);
		System.out.print("영화명 : ");
		String title=scan.next();
		for(int i=0;i<=20;i++){
			String review = movie_review(title,1);
			jsonParse(review);
		}
       movieFeel();
		
	}
	public static String movie_review(String moive_name,int page)
	{
		StringBuffer sb = new StringBuffer();
		try{
			String key="ba61a58fa99b378c4a5de0bbae0fea74";
			URL url = new URL("https://apis.daum.net/search/blog?apikey="+key
					+"&q="+URLEncoder.encode(moive_name,"UTF-8")
					+"&output=json&result=20&pageno="+page);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			if(conn!=null)
			{
			   BufferedReader in = new BufferedReader
					                (new InputStreamReader(conn.getInputStream(), "UTF-8"));
			   String data="";
			   while(true){
				   data=in.readLine();
				   if(data==null) break;
				   sb.append(data+"\n");
			   }
			}
		}catch(Exception ex){
			
		}
		return sb.toString();
	}
	/*
	 *  {channel:{item:[{},{}]}}
	 *  {} => JSONObject
	 *  [] => JSONArray
	 *  "pubdate"
	 *  "author"
	 *  "title"
	 *  "description" 
	 */
	public static void jsonParse(String json){
		try{
			JSONParser jp = new JSONParser();
			JSONObject jo = (JSONObject)jp.parse(json);
			JSONObject channel = (JSONObject)jo.get("channel");
			JSONArray item = (JSONArray)channel.get("item");
			String desc="";
			for(int i=0;i<item.size();i++){
				JSONObject obj=(JSONObject)item.get(i);
				String data=(String)obj.get("description");
				desc+=data+"\n";
			}
			desc=desc.replaceAll("[A-Za-z]","");
			desc=desc.replace("&","");
			desc=desc.replace("?","");
			desc=desc.replace(";","");
			desc=desc.replace("/","");
			desc=desc.replace(".","");
			desc=desc.replace("#","");
			//System.out.println(desc);
			FileWriter fw = new FileWriter("C://data//desc.txt");
			fw.write(desc);
            fw.close();
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
	}
    public static void movieFeel()
    {
    	String[] feel = {"사랑","로맨스","매력","즐거움","스릴",
				"소름","긴장","공포","유머","웃음","개그",
				"행복","전율","경이","우울","절망","신비",
				"여운","희망","긴박","감동","감성","휴머니즘",
				"자극","재미","액션","반전","비극","미스테리",
				"판타지","꿈","설레임","흥미","풍경","일상",
				"순수","힐링","눈물","그리움","호러","충격","잔혹"};
    	
/*    	int[] count=new int[feel.length];
    	try
    	{
    		RConnection rc=new RConnection();
    		
    		 *   install.packages() : library로딩 
    		 *   library() : import
    		 
    		rc.voidEval("library(KoNLP)");
    		rc.voidEval("f<-file(\"c:/image/desc1.txt\")");
    		rc.voidEval("review<-readLines(f)");
    		rc.voidEval("nouns<-sapply(review,extractNoun,USE.NAMES=F)");
    		rc.setStringEncoding("utf8");
    		for(int i=1;i<=20;i++)
    		{
	    		REXP p=rc.eval("nouns[["+i+"]]");
	    		String[] data=p.asStrings();
	    		for(int j=0;j<feel.length;j++)
	    		{
		    		for(String s:data)
		    		{
		    			if(feel[j].equals(s))
		    			{
		    				count[j]++;
		    			}
		    		}
	    		}
    		}
    		for(int i=0;i<feel.length;i++)
    		{
    			if(count[i]==0)continue;
    			System.out.println(feel[i]+" "+count[i]);
    		}
    		
    	}catch(Exception ex){}*/
    }
}





