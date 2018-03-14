package com.hadoop.avro;

import java.io.File;
import java.io.IOException;

import org.apache.avro.Schema;
import org.apache.avro.file.DataFileWriter;
import org.apache.avro.generic.GenericData;
import org.apache.avro.generic.GenericDatumWriter;
import org.apache.avro.generic.GenericRecord;
import org.apache.avro.io.DatumWriter;

public class SerializeNew {
	public static void main(String args[]) throws IOException {
		// Instantiating the Schema.Parser class.
		Schema schema = new Schema.Parser().parse(new File("/Users/avinash/Downloads/Avro/emp.avsc"));
		// Instantiating the GenericRecord class.
		GenericRecord e1 = new GenericData.Record(schema);
		// Insert data according to schema
		e1.put("name", "Avinash");
		e1.put("id", 378476);
		e1.put("salary", 10000);
		e1.put("age", 29);
		e1.put("address", "Hyderabad");
		GenericRecord e2 = new GenericData.Record(schema);
		e2.put("name", "Prasanna");
		e2.put("id", 378477);
		e2.put("salary", 35000);
		e2.put("age", 29);
		e2.put("address", "Detroit");
		DatumWriter<GenericRecord> datumWriter = new GenericDatumWriter<GenericRecord>(schema);
		DataFileWriter<GenericRecord> dataFileWriter = new DataFileWriter<GenericRecord>(datumWriter);
		dataFileWriter.create(schema, new File("/Users/avinash/Downloads/Avro/mydata.txt"));
		dataFileWriter.append(e1);
		dataFileWriter.append(e2);
		dataFileWriter.close();
		System.out.println("data successfully serialized");
	}
}
