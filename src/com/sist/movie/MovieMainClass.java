package com.sist.movie;

import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.rosuda.REngine.Rserve.RConnection;

import kr.co.shineware.nlp.komoran.core.analyzer.Komoran;
import kr.co.shineware.util.common.model.Pair;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
public class MovieMainClass {
	static Komoran komoran=new Komoran("C:\\data");
	static List<Word> list=new ArrayList<Word>();
	public static void main(String[] args){
		
	}
	public static void movieExecute(String movie_name)
	{
		try
		{
			File temp=new File("c://data//desc.txt");
			if(temp.exists())
				temp.delete();
			list.clear();
		
	        for(int i=1;i<=20;i++)
	        {
	          String review=movie_review(movie_name, i);
	          //System.out.println(review);
	          jsonParse(review);
	        }
	        
			File file = new File("c:\\data\\desc.txt");
			FileReader fr = new FileReader(file);

			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file),"EUC-KR"));

			String str = "";
			while((str = br.readLine()) != null) {
				komo(str);
			}
			
			String s1 = "";
			int ttt = 1;
			for(int i=0; i<list.size(); i++){
				for(int j=i; j<list.size(); j++){
					if(list.get(j).getCount()>list.get(i).getCount()){
						s1 = list.get(i).getWord();
						ttt = list.get(i).getCount();
						list.get(i).setWord(list.get(j).getWord()); 
						list.get(i).setCount(list.get(j).getCount());
						list.get(j).setWord(s1);
						list.get(j).setCount(ttt);
					}
				}
			}
			
//			for(Word tmp:list){
//				System.out.println(tmp.getWord()+" "+tmp.getCount());
//			}
			String[] feel = {"사랑","로맨스","매력","즐거움","스릴",
					"소름","긴장","공포","유머","웃음","개그",
					"행복","전율","경이","우울","절망","신비",
					"여운","희망","긴박","감동","감성","휴머니즘",
					"자극","재미","액션","반전","비극","미스테리",
					"판타지","꿈","설레임","흥미","풍경","일상",
					"순수","힐링","눈물","그리움","호러","충격","잔혹"};
			String data="word,count\n";	
			for(Word tmp:list){
				for(int k = 0; k<feel.length; k++){
					if(feel[k].equals(tmp.getWord()))
					{
						data+=tmp.getWord()+","+tmp.getCount()+"\n";
						//System.out.println(tmp.getWord()+" "+tmp.getCount());
					}
				}
//				System.out.println(tmp.getWord()+" "+tmp.getCount());
			}
			File feelFile=new File("C:\\data\\feel.csv");
			if(!feelFile.exists())
				feelFile.createNewFile();
			FileWriter fw=new FileWriter(feelFile);
			fw.write(data);
			fw.close();
			
		}catch(Exception ex)
		{
			System.out.println(ex.getMessage());
		}
	}
	public static void createFeelImage()
	{
		try
		{
			RConnection rc=new RConnection();
			rc.voidEval("feel<-read.csv(\"c:/data/feel.csv\",header=T,sep=\",\")");
			rc.voidEval("png(\"C:/webDev/webStudy4/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/JSPIncludeProject/image/feel.png\",width=600,height=400)");
			rc.voidEval("barplot(feel$count,names.arg=feel$word,col=rainbow(15))");
			rc.voidEval("dev.off()");
			rc.close();
		}catch(Exception ex){}
	}
	public static void komo(String s){
		List<List<Pair<String,String>>> result=komoran.analyze(s);
		
		for (List<Pair<String, String>> eojeolResult : result) {
			for (Pair<String, String> wordMorph : eojeolResult) {
				if(wordMorph.getSecond().equals("NNG")||wordMorph.getSecond().equals("NNP")){
					boolean ch=true;
					for(Word tmp:list){
						if(tmp.getWord().equals(wordMorph.getFirst())){
							int count=tmp.getCount()+1;
							tmp.setCount(count);
							ch=false;
							break;
						}
					}
					if(ch){
						Word a=new Word();
						a.setWord(wordMorph.getFirst());
						a.Incerement();
						list.add(a);
					}
				}
			}
		}
	}
	public static String movie_review(String movie_name,int page)
    {
		
    	StringBuffer sb=new StringBuffer();
    	try
    	{
    		String key="ba61a58fa99b378c4a5de0bbae0fea74";
    		URL url=new URL("https://apis.daum.net/search/blog?apikey="+key
    				+"&q="+URLEncoder.encode(movie_name, "UTF-8")
    				+"&output=json&result=20&pageno="+page);
    		HttpURLConnection conn=
    				  (HttpURLConnection)url.openConnection();
    		conn.connect();
    		if(conn!=null)
    		{
    			BufferedReader in=
    				new BufferedReader(
    						new InputStreamReader(conn.getInputStream(), "UTF-8"));
    			String data="";
    			while(true)
    			{
    				data=in.readLine();
    				if(data==null) break;
    				sb.append(data+"\n");
    			}
    		}
    		conn.disconnect();
    	}catch(Exception ex){}
    	return sb.toString();
    }
	public static void jsonParse(String json)
    {
    	try
    	{
    		JSONParser jp=new JSONParser();
    		JSONObject jo=(JSONObject)jp.parse(json);
    		JSONObject channel=(JSONObject)jo.get("channel");
    		JSONArray item=(JSONArray)channel.get("item");
    		String desc="";
    		for(int i=0;i<item.size();i++)
    		{
    			JSONObject obj=(JSONObject)item.get(i);
    			String data=(String)obj.get("description");
    			desc+=data+"\n";
    		}
    		desc=desc.replaceAll("[A-Za-z0-9]", "");
    		desc=desc.replace("&", "");
    		desc=desc.replace("?", "");
    		desc=desc.replace(";", "");
    		desc=desc.replace("/", "");
    		desc=desc.replace(".", "");
    		desc=desc.replace("#", "");
    		//System.out.println(desc);
    		
    		FileWriter fw=new FileWriter("c://data//desc.txt",true);    //
    		fw.write(desc);
    		fw.close();
    	}catch(Exception ex){System.out.println(ex.getMessage());}
    }
}
