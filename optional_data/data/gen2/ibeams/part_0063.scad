$fn = 32;

// ----------------------------------------------------------------------
// Lattice I-beam: 80 mm long, 50 mm deep, 4 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 4;               // number of web panels
panel_p = 20;             // panel length, X
length = 80;              // beam length
beam_h = 50;              // depth between the flange axes
flange_r = 3.5;           // flange tube radius
web_r = 3;                // web brace radius
joint_r = 4.2;            // joint ball radius

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

bottom = [for (i = [0 : panels]) [i * panel_p, 0, 0]];
top = [for (i = [0 : panels]) [i * panel_p, 0, beam_h]];

/* flanges */
for (i = [0 : panels - 1]) {
  member(bottom[i], bottom[i + 1], flange_r);
  member(top[i], top[i + 1], flange_r);
}

/* continuous zig-zag web */
for (i = [0 : panels - 1]) {
  if (i % 2 == 0) {
    member(bottom[i], top[i + 1], web_r);
  } else {
    member(top[i], bottom[i + 1], web_r);
  }
}

/* joint balls */
for (i = [0 : panels]) {
  joint(bottom[i], joint_r);
  joint(top[i], joint_r);
}
