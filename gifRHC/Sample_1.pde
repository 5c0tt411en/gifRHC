public class Sample_1 {
	private float transX;
	private float transY;
	private float r;
	private float rArray;

	public Sample_1(float transX, float transY, float r, float rArray) {
		this.transX = transX;
		this.transY = transY;
		this.r = r;
		this.rArray = rArray;
	}

	public void displaySample_1() {
		noFill();
		strokeWeight(1);
		stroke(255);
		translate(width / 2, height / 2);
	}

	public void revolve() {
		if (rArray < 0) rArray -= 0.006;
		else if (rArray > 0) rArray += 0.006;
		rotateY(rArray);
	}

	public void drawCubes() {
		pushMatrix();
		translate(0, transY * (p5 + p7 * in.left.get(100) * 10) * 4);
		/* box(p1 * 50, 5, p1 * 50); */
		pushMatrix();
		rotateX(r * p8);
		rotateY(r * p9);
		rotateZ(r * p10);
		translate(transX * p4 * 2, 0);
		ellipse(1 + p1 * 50, 20 + (p2 + p7 * in.left.get(100) * 10) * 50, (p7 + p2) * 40, 50);
		ellipse(p3 * 50, p4 * 20, 50, 50 * (p7 + p2));
		popMatrix();
		popMatrix();

	}
}

