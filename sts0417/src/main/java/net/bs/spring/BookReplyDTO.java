package net.bs.spring;

import java.sql.Timestamp;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter

public class BookReplyDTO {
	private int bi_num;
	private int r_num;
	private String r_id;
	private String r_content;
	private Timestamp r_datetime;
	private String r_date;
	private int grp;
	private int seq;
	private int lvl;
	private int r_stars;
	private int r_hit;
	private int start;
	private int end;
}//ReplyDTO  class END
