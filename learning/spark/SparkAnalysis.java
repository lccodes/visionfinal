import com.jmatio.*;

import org.apache.spark.api.java.*;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.mllib.clustering.KMeans;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.SparkConf;

import java.util.List;
import java.util.LinkedList;

public class SparkAnalysis {
	public final JavaRDD<Float[]> data;
	public final JavaSparkContext sc;

	public SparkAnalysis(String arrayName, String filename) {
		SparkConf conf = new SparkConf().setAppName("Team Intervention Clustering");
    	sc = new JavaSparkContext(conf);

		MatFileReader reader = new MatFileReader(filename);
		features = (MLSingle) reader.getMLArray(arrayName);
		List<Float[]> values = new LinkedList<Float[]>();
		for (int i = 0; i < features.getDimensions()[0]; i++) {
			Float[] v = new Float[x.getDimensions()[1]];
			for (int j = 0; j < features.getDimensions()[1]; j++) {
				v[j] = features.get(i + (i*j));
			}
			values.add(v);
		}
		data = sc.parallelize(values);
		data.cache();
	}

	public void KMeans() {
		KMeansModel best;
		double SSE = Double.MAX_VALUE;
		for (int i = 4; i < 10; i++) {
			for (int j = 10; j < 30; j++) {
				KMeansModel clusters = KMeans.train(data.rdd(), i, j);
				double CSSE = clusters.computeCost(data.rdd());
				if (CSSE < SSE) {
					best = clusters;
					SSE = CSSE;
				}
			}
		}

		clusters.save(sc.sc(), "models/bestKMeans" + Math.random());
	}

	public static void main(String[] args) {
		SparkAnalysis sa = SparkAnalysis("simple_actions", "luke_data/<file>");
		sa.KMeans();
	}
}