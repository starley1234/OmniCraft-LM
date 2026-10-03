$fn = 32;
// ----------------------------------------------------------------------
// Spur gear: m=3 z=25, 81 mm tip diameter x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
modul = 3;                // module
n_teeth = 25;             // number of teeth
width = 8;                // face width
pa = 20;                  // pressure angle, deg
shaft_d = 12;             // shaft bore
boss_d = 41.9;            // hub diameter
boss_h = 8;               // hub above the face
light_d = 8.1;            // lightening hole diameter
light_r = 27.4;           // lightening hole pitch radius
key_w = 5;                // keyway width
key_h = 2.3;              // keyway depth
set_d = 4.5;              // set screw tap hole
set_z = 12;               // set screw height

/* --- involute profile --- */
pitch_r = modul * n_teeth / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + modul;
root_r = pitch_r - 1.25 * modul;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / n_teeth + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / n_teeth + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : n_teeth - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / n_teeth)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = width) tooth_profile();
}

module hub_boss() {
  translate([0, 0, width - 1]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    gear_disc();
    hub_boss();
  }
  translate([0, 0, -1]) cylinder(h = width + boss_h + 3, d = shaft_d);
  /* lightening holes in the web */
  for (i = [0 : 4 - 1]) rotate([0, 0, i * 360 / 4]) translate([light_r, 0, -1])
    cylinder(h = width + 3, d = light_d);
  /* keyway on the bore */
  translate([-shaft_d / 2 - 1, -key_w / 2, -1]) cube([key_h + 1, key_w, width + boss_h + 3]);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = boss_d / 2 + 3, d = set_d);
}
