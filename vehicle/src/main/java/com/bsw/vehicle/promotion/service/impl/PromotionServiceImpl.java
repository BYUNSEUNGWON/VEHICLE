package com.bsw.vehicle.promotion.service.impl;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bsw.vehicle.mapper.PromotionMapper;
import com.bsw.vehicle.model.AttachVO;
import com.bsw.vehicle.model.PromotionVO;
import com.bsw.vehicle.promotion.service.PromotionService;

@Service
public class PromotionServiceImpl implements PromotionService{
	
	@Autowired
	PromotionMapper promotionMapper;
	
    @Value("${file.upload-dir}")
    private String uploadDir;
    
    @Value("${server.base.url}")
    private String serverBaseUrl;
	

	@Override
	public int insertContensts(PromotionVO promotion) {
		
	    int result = promotionMapper.insertContents(promotion);
	    
	    if (result == 1) {
	        return 1;
	    } else {
	        return 0;
	    }
	    
	}


	@Override
	public String uploadAttach(MultipartFile uploadedFile, String fileId , String ext, String registUserId) {
		
		AttachVO attach = new AttachVO();
		
		if (uploadedFile.isEmpty()) {
            return "파일이 비어 있습니다.";
        }

        // 현재 날짜를 기반으로 디렉토리 경로 생성
        LocalDate currentDate = LocalDate.now();
        String datePath = currentDate.getYear() + File.separator 
                        + currentDate.getMonthValue() + File.separator 
                        + currentDate.getDayOfMonth();

        // 년/월/일 구조의 업로드 디렉토리 확인 및 생성
        File directory = new File(uploadDir, datePath);
        if (!directory.exists()) {
            boolean dirsCreated = directory.mkdirs();
            if (!dirsCreated) {
                return "디렉토리 생성 실패";
            }
        }

        // 파일 저장 로직
        try {
            String originalFilename = uploadedFile.getOriginalFilename();
            if (originalFilename == null || originalFilename.isEmpty()) {
                return "잘못된 파일명입니다.";
            }

            File destinationFile = new File(directory, originalFilename);
            uploadedFile.transferTo(destinationFile);
            
            String fileUrl = serverBaseUrl + "/files/" + datePath.replace(File.separator, "/") + "/" + URLEncoder.encode(originalFilename, "UTF-8");
            
            attach.setOri_name(originalFilename);
            attach.setFile_id(fileId);
            attach.setFile_size(Long.toString(uploadedFile.getSize()));
            attach.setFile_path(destinationFile.getAbsolutePath());
            attach.setFile_ext(ext);
            attach.setRegist_user_id(registUserId);
            attach.setFile_url(fileUrl);
            
            promotionMapper.insertFile(attach);

            return "SUCCESS";

        } catch (IOException e) {
            e.printStackTrace();
            return "파일 업로드 실패: " + e.getMessage();
        }
    }


	@Override
	public int countProIdx() {
		return promotionMapper.countProIdx();
	}


	@Override
	public PromotionVO getProItem(int i) {
		return promotionMapper.getProItem(i);
	}


	@Override
	public StringBuilder getContents(StringBuilder gridItemsBuilder, PromotionVO promotion, int i) {
		
		String imageUrl = promotionMapper.getImgUrl(i);
		//https://cdn-icons-png.flaticon.com/512/3875/3875148.png
		if(imageUrl == "" || imageUrl == null || imageUrl.isEmpty()) {
			imageUrl = "https://static.vecteezy.com/system/resources/thumbnails/025/802/216/small_2x/no-image-symbol-no-photo-available-icon-illustration-eps-vector.jpg";
		}
		String userId = promotion.getRegist_user_id();
		String litContents = promotion.getContents();
		
		litContents = litContents.replaceAll("<br>", "");
		
		if (litContents.length() > 250) {
		    litContents = litContents.substring(0, 250) + "....." + "<span style=\"font-weight: bold;\">[더보기]</span>";
		} else {
		    // 길이가 300자보다 짧은 경우, 공백으로 채웁니다
		    int paddingLength = 250 - litContents.length();
		    StringBuilder padding = new StringBuilder();
		    for (int j = 0; j < paddingLength; j++) {
		        padding.append(" ");
		    }
		    litContents = litContents + padding.toString();
		    litContents = litContents.substring(0, 250) + "....." + "<span style=\"font-weight: bold;\">[더보기]</span>";
		}

		
		String proId = promotion.getPromotion_id();
		
		return gridItemsBuilder.append("\r\n")
			    .append("        <div class=\"grid-item\" style=\"display: flex; position: relative; width: 100%; background-color: #f3f3f3; padding: 10px;\">\r\n") 
			    .append("            <div class=\"grid-detail\" style=\"flex: 2; padding: 10px; display: flex; align-items: center;\">\r\n")
			    .append("                <div onclick=\"showItem('")
			    .append(promotion.getTitle().replace("'", "\\'"))
			    .append("', '")
			    .append(proId) 
			    .append("')\">")
			    .append("                    <div id=\"title\">\r\n")
			    .append("                        <h2>")
			    .append(promotion.getTitle())
			    .append("</h2>\r\n")
			    .append("                    </div>\r\n")
			    .append("                    <div id=\"litContents\">\r\n")
			    .append(litContents)
			    .append("                    </div>\r\n")
			    .append("                </div>\r\n")
			    .append("            </div>\r\n")
			    .append("            <div class=\"grid-image\" style=\"flex: 1; display: flex; align-items: center; justify-content: center; padding: 10px;\">\r\n")
			    .append("                <img src=\"")
			    .append(imageUrl) 
			    .append("\" alt=\"Promotion Image\" style=\"width: 100%; height: 100%; object-fit: cover; border-radius: 10px;\" />\r\n")
			    .append("            </div>\r\n")
			    .append("        </div>\r\n");

	}


	@Override
	public PromotionVO showDetail(String promotion_id, String title) {
		return promotionMapper.getDetail(promotion_id, title);
	}
}


