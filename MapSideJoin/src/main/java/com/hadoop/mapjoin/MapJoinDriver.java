package com.hadoop.mapjoin;

import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.filecache.DistributedCache;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class MapJoinDriver extends Configured implements Tool {

	public int run(String[] arg0) throws Exception {


		Job job = Job.getInstance(getConf(),"Map Side Join");
		job.setJarByClass(MapJoinDriver.class);
		job.setJobName("Map Side Join");
		
		job.setMapperClass(MapJoinMapper.class);
		job.setNumReduceTasks(0);
		
		Path customerinput = new Path(arg0[0]);
		Path orderinput = new Path(arg0[1]);
		Path output = new Path(arg0[2]);
		
		DistributedCache.addCacheFile(customerinput.toUri(), job.getConfiguration());

		
		FileInputFormat.addInputPath(job, orderinput);
		FileOutputFormat.setOutputPath(job, output);
		
		return job.waitForCompletion(true)? 0 :1 ;
	}

	public static void main(String[] args) {

		try {
			int res = ToolRunner.run(new MapJoinDriver(), args);
			System.exit(res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}