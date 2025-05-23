package com.dat3m.dartagnan.asm.ppc64.ck;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.EnumSet;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.sosy_lab.common.ShutdownManager;
import org.sosy_lab.common.configuration.Configuration;
import org.sosy_lab.common.configuration.InvalidConfigurationException;
import org.sosy_lab.common.log.BasicLogManager;
import org.sosy_lab.java_smt.SolverContextFactory;
import org.sosy_lab.java_smt.api.SolverContext;

import com.dat3m.dartagnan.configuration.Arch;
import static com.dat3m.dartagnan.configuration.Property.PROGRAM_SPEC;
import static com.dat3m.dartagnan.configuration.Property.TERMINATION;
import com.dat3m.dartagnan.encoding.ProverWithTracker;
import com.dat3m.dartagnan.parsers.cat.ParserCat;
import com.dat3m.dartagnan.parsers.program.ProgramParser;
import com.dat3m.dartagnan.program.Program;
import static com.dat3m.dartagnan.utils.ResourceHelper.getRootPath;
import static com.dat3m.dartagnan.utils.ResourceHelper.getTestResourcePath;
import com.dat3m.dartagnan.utils.Result;
import com.dat3m.dartagnan.verification.VerificationTask;
import com.dat3m.dartagnan.verification.solving.RefinementSolver;
import com.dat3m.dartagnan.wmm.Wmm;

@RunWith(Parameterized.class)
public class AsmCkPpc64Test {

    private final String modelPath = getRootPath("cat/power.cat");
    private final String programPath;
    private final int bound;
    private final Result expected;

    public AsmCkPpc64Test (String file, int bound, Result expected) {
        this.programPath = getTestResourcePath("asm/ppc64/ck/" + file + ".ll");
        this.bound = bound;
        this.expected = expected;
    }

    @Parameterized.Parameters(name = "{index}: {0}, {1}, {2}")
    public static Iterable<Object[]> data() throws IOException {
        return Arrays.asList(new Object[][]{
            {"anderson", 3, Result.PASS},
            {"caslock", 3, Result.PASS},
            {"clhlock", 1, Result.PASS},
            {"declock", 3, Result.PASS},
            {"faslock", 3, Result.PASS},
            {"mcslock", 2, Result.PASS},
            {"ticketlock", 1, Result.PASS},
            {"spsc_queue", 1, Result.PASS},
            {"stack_empty", 3, Result.PASS},
        });
    }

    @Test
    public void testAllSolvers() throws Exception {// TODO : RefinementSolver takes too long to run, we have to investigate this
        try (SolverContext ctx = mkCtx(); ProverWithTracker prover = mkProver(ctx)) {
            assertEquals(expected, RefinementSolver.run(ctx, prover, mkTask()).getResult());
        }
    }

    private SolverContext mkCtx() throws InvalidConfigurationException {
        Configuration cfg = Configuration.builder().build();
        return SolverContextFactory.createSolverContext(
                cfg,
                BasicLogManager.create(cfg),
                ShutdownManager.create().getNotifier(),
                SolverContextFactory.Solvers.YICES2);
    }

    private ProverWithTracker mkProver(SolverContext ctx) {
        return new ProverWithTracker(ctx, "", SolverContext.ProverOptions.GENERATE_MODELS);
    }

    private VerificationTask mkTask() throws Exception {
        VerificationTask.VerificationTaskBuilder builder = VerificationTask.builder()
                .withConfig(Configuration.builder().build())
                .withBound(bound)
                .withTarget(Arch.POWER);
        Program program = new ProgramParser().parse(new File(programPath));
        Wmm mcm = new ParserCat().parse(new File(modelPath));
        return builder.build(program, mcm, EnumSet.of(TERMINATION, PROGRAM_SPEC));
    }
}
