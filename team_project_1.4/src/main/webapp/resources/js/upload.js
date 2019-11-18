/**
 * file Upload
 */

function checkImageType(fileName) {
		var pattern = /jpg|gif|png|jpeg/i;
		return fileName.match(pattern);
	}
	
function getFileInfo(fullName) {
		var imgSrc, fileName, getLink;
		
		if(checkImageType(fullName)){
			// Image
			imgSrc = "/displayFile?fileName="+fullName;
			getLink = "/displayFile?fileName="+fullName.replace("s_", "");
		}else{
			// 일반 파일
			imgSrc = "/resources/img/file.png";
			getLink = "/displayFile?fileName="+fullName;
		}
		
		fileName = fullName.substr(fullName.lastIndexOf("_")+1);
		return {fileName : fileName, imgSrc : imgSrc, fullName : fullName, getLink : getLink};
	}