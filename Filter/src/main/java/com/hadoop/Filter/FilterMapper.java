package com.hadoop.Filter;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class FilterMapper extends Mapper<LongWritable, Text, Text, NullWritable> {
	
	@Override
	protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, NullWritable>.Context context)
			throws IOException, InterruptedException {
		// TODO Auto-generated method stub
		if(value.toString().contains("date")) {
			return;
		}
		else {
			String record = value.toString();
			if(record.split(",").length == 16) {
		
			String string_views =record.split(",")[7];
			if ((string_views != null) & (string_views.matches("[0-9]+"))) {
				long views = Long.parseLong(record.split(",")[7]);
				if(views > 100000) {
					String title = record.split(",")[2];
					context.write(value, NullWritable.get());
				}
			}	
				
			}
			
			
		}
		
	}

}
