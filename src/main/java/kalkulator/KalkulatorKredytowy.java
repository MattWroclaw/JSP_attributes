package kalkulator;

public class KalkulatorKredytowy {
    private double q = 1;
    private double m=1;
    private double A=1;
    private double b=1;
    private double n=1;
    private double R=1;
    private double C=1;


    public double getQ() {
        return q;
    }

    public void setQ(double q) {
        this.q = q;
    }

    public double getM() {
        return m;
    }

    public void setM(double m) {
        this.m = m;
    }

    public double getA() {
        return A;
    }

    public void setA(double a) {
        A = a;
    }

    public double getB() {
        return b;
    }

    public void setB(double b) {
        this.b = b;
    }

    public double getN() {
        return n;
    }

    public void setN(double n) {
        this.n = n;
    }

    public double getR() {
        return R;
    }

    public void setR(double r) {
        R = r;
    }

    public double getC() {
        return C;
    }

    public void setC(double c) {
        C = c;
    }

    public double q(double b, double m) {
        return 1 + (b / m);
    }

    public double R(double A, double q, double n) {
        return (A * Math.pow(q, n) * (q - 1)) / (Math.pow(q, n) - 1);
    }

    public double C(double R, double n){
        return R *n;
    }

}
