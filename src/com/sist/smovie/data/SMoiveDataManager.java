package com.sist.smovie.data;
import java.util.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class SMoiveDataManager {
	public static List<SMoiveDTO> moiveAllData()
	{
		List<SMoiveDTO> list = new ArrayList<SMoiveDTO>();
		try{
			Document doc=Jsoup.connect("http://www.seoulcinema.com/02_movie/2100_ing_list.php").get();
			
			//.movie_view .view .meta table th, .movie_view .view .meta table td
			Elements titleElem=doc.select("div.movie_data .list li .title strong");
			Elements imgElem=doc.select("div.movie_data .list li .img img");
			Elements mid = doc.select("div.movie_data .list li .btn a.btn_info");
			
			for(int i=0;i<titleElem.size();i++)
			{
				Element telem= titleElem.get(i);
				Element ielem= imgElem.get(i);
			  /*  String melem= (mid.text().substring(mid.text().lastIndexOf(5),4));*/
		 
				System.out.println(mid);
				String img=ielem.attr("src");
				
				SMoiveDTO d = new SMoiveDTO();
				d.setTitle(telem.text());
				d.setImage(img);
				list.add(d);
				System.out.println(telem.text()+" "+img);
				}	
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		return list;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<SMoiveDTO> list =moiveAllData();
		for(SMoiveDTO d:list)
		{
			/*System.out.println(d.getTitle());
			System.out.println(d.getImage());*/
		}
	}

}
