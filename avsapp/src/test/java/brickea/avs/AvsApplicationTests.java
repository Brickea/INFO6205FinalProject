package brickea.avs;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class AvsApplicationTests {

    @Test
    void SIRFormulasTest() {

        double r = 0.02;
        double a = 0.05;

        int oldS = 10000;
        int oldI = 20;
        int oldR = 0;

        int newS = (int) (oldS - r*oldI*oldS);
        int newI = (int) (oldI + r*oldI*oldS - a*oldI);
        int newR = (int) (a*oldI + oldR);

        assert Math.abs(newS-6000) <10;
        assert Math.abs(newI-4019) <10;
        assert Math.abs(newR-1) <10;
    }

}
