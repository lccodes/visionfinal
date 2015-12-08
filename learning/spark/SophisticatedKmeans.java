import org.apache.spark.api.java.*;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.mllib.clustering.KMeans;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.SparkConf;

import java.util.List;
import java.util.LinkedList;

public class SophisticatedKmeans {
	public final JavaRDD<Vector[]>[] trainData;
	public final JavaRDD<Vector[]>[] testData;
	public final JavaSparkContext sc;

	public SophisticatedKmeans(String tld) {
		SparkConf conf = new SparkConf().setAppName("Team Intervention Clustering");
    	sc = new JavaSparkContext(conf);

    	File dir = new File(tld);
    	File[] subdirs = dir.listFiles();
    	File[] ordered = new File[4];
    	for (File f : subdirs) {
    		if (f.getName().contains("Drinking")) {
    			ordered[0] = f;
    		} else if (f.getName().contains("Hugs")) {
    			ordered[1] = f;
    		} else if (f.getName().contains("Kiss")) {
    			ordered[2] = f;
    		} else if (f.getName().contains("Handshake")) {
    			ordered[3] = f;
    		}
    	}

    	JavaRDD<Vector[]>[] features = new JavaRDD<Vector[]>[4];
    	for (int i = 0; i < 4; i++) {
    		List<FlVeoat[]> allTrain = new LinkedList<Vector[]>();
    		List<FlVeoat[]> allTest = new LinkedList<Vector[]>();
    		for (File f : sub[i].listFiles()) {
    			try {
    				BufferedReader br = new BufferedReader(new FileReader(f));
    				String lines;
    				while((lines += br.readLine()) != null) {}
    				String[] vals = line.split(" ");
					Double[] values = new Double[vals.length];
					for (int x = 0; x < vals.length; x++) {
						values = Double.parseDouble(vals[x]);
					}
					if (Math.random() < .8)
						allTrain.add(Vector.dense(values));
					else
						allTest.add(Vector.dense(values))

    			} catch (IOException e) {
    				e.printStackTrace();
    				break;
    			}
    		}
    		trainData[i] = sc.parallelize(allTrain);
    		testData[i] = sc.parallelize(allTest);
    	}

    	data = features;
	}

	public void KMeans() {
		KMeansModel clusters = KMeans.train(allTrain[0].union(allTrain[1]).union(allTrain[2]).union(allTrain[3]).rdd(), 4, 30);
		List<Integer>[] predictions = new List<Integer>[4];
		for (int i = 0; i < 4; i++) {
			predictions[i] = clusters.predict(testData[i]).collect();
		}
		int[] accuracy = new int[4];
		int[] total = new int[4];
		for (int i = 0; i < 4; i++) {
			for (int p : predictions[i]) {
				if (p == i) {
					accuracy[i]++;
				}
				total[i]++;
			}
		}

		System.out.println("drinking,hugs,kiss,handshake,overall");
		for (int i = 0; i < 4; i++) {
			System.out.print(acc[i]/total[i] + ",");
		}
		System.out.prin((acc[0]+acc[1]+acc[2]+acc[3])/(total[0]+total[1]+total[2]+total[3]));

	}

	public static void main(String[] args) {

	}
}