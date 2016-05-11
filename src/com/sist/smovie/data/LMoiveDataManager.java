package com.sist.smovie.data;
import java.util.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class LMoiveDataManager {
	public static List<SMoiveDTO> moiveAllData()
	{
		List<SMoiveDTO> list = new ArrayList<SMoiveDTO>();
		try{
			Document doc=Jsoup.connect("http://www.lottecinema.co.kr/LCHS/Contents/Movie/Movie-List.aspx").get();
			System.out.println(doc);
			//.movie_view .view .meta table th, .movie_view .view .meta table td
			Elements titleElem=doc.select("div.movie_clist.curr_list .list_text");
			Elements imgElem=doc.select("div.movie_clist.curr_list .img img");
			for(int i=0;i<titleElem.size();i++)
			{
				Element telem= titleElem.get(i);
				Element ielem= imgElem.get(i);
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
			System.out.println(d.getTitle());
			System.out.println(d.getImage());
		}
	}

}
