package com.sist.movie.data;
import java.util.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MoiveDataManager {
	public static List<MoiveDTO> moiveAllData()
	{
		List<MoiveDTO> list = new ArrayList<MoiveDTO>();
		try{
			Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/?lt=1&ft=0").get();
			//System.out.println(doc);
			Elements titleElem=doc.select("div.box-contents strong.title");
			Elements percentElem=doc.select("div.box-contents strong.percent");
			Elements imgElem=doc.select("div.box-image span.thumb-image img");
			Elements likeElem=doc.select("div.box-contents span.like span.count strong i");
			Elements rElem=doc.select("div.box-contents span.txt-info strong");
			Elements sElem=doc.select("div.box-contents span.percent");
			for(int i=0;i<titleElem.size();i++)
			{
				Element telem= titleElem.get(i);
				Element pelem= percentElem.get(i);
				Element ielem= imgElem.get(i);
				Element lelem= likeElem.get(i);
				Element relem= rElem.get(i);
				Element selem= sElem.get(i);
				String img=ielem.attr("src");
				MoiveDTO d = new MoiveDTO();
				d.setNo(i+1);
				d.setTitle(telem.text());
				d.setImage(img);
				int like=Integer.parseInt(lelem.text().replace(",", ""));
				d.setLike(like);
				d.setRegdate(relem.text().substring(0, relem.text().indexOf("°³ºÀ")).trim());
			    d.setPercent(pelem.text().substring(3, pelem.text().indexOf('%')));
			    d.setReserve(Double.parseDouble(selem.text().substring(0, selem.text().indexOf('%'))));
			    list.add(d);
				//System.out.println(telem.text()+" "+pelem.text()+" "+img+" "+lelem.text()+" "+relem.text()+" "
				//		+selem.text());
			}	
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		return list;
	}
/*	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<MoiveDTO> list =moiveAllData();
		for(MoiveDTO d:list)
		{
			System.out.println(d.getTitle());
			System.out.println(d.getImage());
			System.out.println(d.getPercent());
			System.out.println(d.getReserve());
			System.out.println(d.getRegdate());
			System.out.println(d.getLike());
		}
	}
*/
}
