package net.bs.spring;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BookinfoDTO {
	private String bi_isbn, bi_title, bi_image, bi_writer, bi_publisher, bi_pdate, bi_content, bi_comment, bi_status;
	//åISBN, å����, å�����url, ����, ���ǻ�, �Ⱓ��, å�Ұ�, �Ǹ��ڸ�Ʈ, å������
	private int bi_num, bi_price, bi_sprice, bi_reco, bi_stars, bi_ratings, bi_event;
	//å��Ϲ�ȣ, å����, å�ǸŰ�, ��õ��������, ������������, ��������hit��, ������̺�Ʈ
	private java.util.Date bi_rdate;
	//����Ʈ�����
}
