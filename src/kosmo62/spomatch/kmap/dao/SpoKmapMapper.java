package kosmo62.spomatch.kmap.dao;

import java.util.List;

import kosmo62.spomatch.kmap.vo.SpoKmapVO;

public interface SpoKmapMapper {
	
	//�� ��ü ��ȸ
	public List<SpoKmapVO> listSpoKmap(SpoKmapVO param);
	
	//ajax �� �ҷ�����
	public List<SpoKmapVO> kakaoMapData(SpoKmapVO param);

}