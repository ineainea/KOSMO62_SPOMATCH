package kosmo62.spomatch.kmap.service;

import java.util.List;

import kosmo62.spomatch.kmap.vo.SpoKmapVO;

public interface SpoKmapService {
	//��ü ��ȸ
	public List<SpoKmapVO> listSpoKmap(SpoKmapVO param);
	
	//Ajax �̺�Ʈ ��ü �ҷ�����
	public List<SpoKmapVO> kakaoMapData(SpoKmapVO param);
}