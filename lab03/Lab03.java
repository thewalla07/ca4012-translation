import java.util.*;

public class Lab03 {
	public static void main(String[] tokens) {
		Scanner s = new Scanner(System.in);
		System.out.print("Enter translation output: ");
		String inStr = s.nextLine();
		System.out.print("Enter the reference output: ");
		String refStr = s.nextLine();
		s.close();

		String[] input = inStr.split(" ");
		String[] ref = refStr.split(" ");

		float precision = getBLEU(input, ref, 4);	
		System.out.println("Precision at 1 gram: "+precision);
		

	}

	public static float getBLEU(String[] input, String[] ref, int ngrams) {
		float brevity = input.length/ref.length;
		brevity = Math.min(1, brevity);
		float precision = brevity * getTotalPrecisionAtNGrams(input, ref, ngrams);
		return precision;
	}

	public static float getTotalPrecisionAtNGrams(String[] input, String[] ref, int ngrams) {
		float precision = 1;
		for (int i = 0;	i < ngrams; i++) {
			ArrayList<String> inGrams = getNGrams(input, ngrams);
			ArrayList<String> refGrams = getNGrams(ref, ngrams);
			precision = precision * getPrecision(inGrams, refGrams);
			
		}
		float one = (float) 1;
		float ng = (float) ngrams;
		float power = one/ng;
		System.out.println(precision +" "+ power);
		double po = (double) power;
		double pr = (double) precision;
		System.out.println(pr +" "+ po);

		pr = Math.pow(pr, po);
		precision = (float) pr;
	
		System.out.println(precision +" "+ pr);
		return precision;
	}

	public static void printAll(ArrayList<String> grams) {
		for (String gram: grams) {
			System.out.println(gram);
		}
	}

	public static ArrayList<String> getNGrams(String[] tokens, int ngrams) {
		ArrayList<String> grams = new ArrayList<>();
		for (int i = 0; i <= tokens.length - ngrams; i++) {
			String thisGram = "";
			for (int j = 0; j < ngrams; j++) {
				thisGram += tokens[i+j] + " ";
			}
			thisGram = thisGram.trim();
			grams.add(thisGram);
		}
		return grams;
	}

	public static float getPrecision(ArrayList<String> input, ArrayList<String> ref) {
		float matches = 0;
		float length = input.size();
		for (String inGram: input) {
			for (int i = 0; i < ref.size(); i++) {
				if(inGram.equals(ref.get(i))) {
					ref.remove(i);
					matches++;
					break;
				} 
			}
		}
		return (matches/length);
	}
}

