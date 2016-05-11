package com.sist.image;
//ba61a58fa99b378c4a5de0bbae0fea74
import org.rosuda.REngine.Rserve.RConnection;

public class CreateMainimage {
   public void logImage()
   {
	   try
	   {
		   String path="C:/webDev/webStudy2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/JSPincludeProject/main/log.csv";
	       RConnection rc=new RConnection();
	       rc.voidEval("data<-read.csv(\"C:/webDev/webStudy2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/JSPincludeProject/main/log.csv\",header=T,sep=\",\")");
	       rc.voidEval("png(\"C:/webDev/webStudy2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/JSPincludeProject/main/log.png\",width=500,height=350)");
	       rc.voidEval("barplot(data$count,names=data$name,col=rainbow(14),main=\"Login Status\")");
	       rc.voidEval("dev.off()");
	       rc.close();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
   }
}
