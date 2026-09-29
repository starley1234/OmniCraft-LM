$fn = 32;

// ----------------------------------------------------------------------
// Pipe route: tube 12 mm, run 60 mm + 40 mm + 45 deg bend
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pipe_r = 6;               // pipe outside radius
joint_r = 7.2;            // joint ball radius
run_a = 60;               // first straight run, X
run_b = 40;               // second straight run, Y
diag = 60;                // 45 degree run, per axis
run_c = 60;               // last straight run, Z

module member(a, b, r) {
  /* rod: cylinder from joint a to joint b */
  d = b - a;
  length = norm(d);
  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])
    cylinder(h = length, r = r);
}

module joint(p, r) {
  /* ball at the joint centre */
  translate(p) sphere(r = r);
}

p0 = [0, 0, 0];
p1 = [run_a, 0, 0];
p2 = [run_a, run_b, 0];
p3 = [run_a + diag, run_b + diag, 0];
p4 = [run_a + diag, run_b + diag, run_c];

member(p0, p1, pipe_r);
member(p1, p2, pipe_r);
member(p2, p3, pipe_r);
member(p3, p4, pipe_r);

/* joint balls */
joint(p0, joint_r);
joint(p1, joint_r);
joint(p2, joint_r);
joint(p3, joint_r);
joint(p4, joint_r);
