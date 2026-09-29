$fn = 32;

// ----------------------------------------------------------------------
// Helical gear: m=2 z=21, helix 25 deg, 46 mm x 26 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
modul = 2;                // normal module
n_teeth = 21;             // number of teeth
width = 18;               // face width
pa = 20;                  // pressure angle, deg
helix = 25;               // helix angle, deg
twist = 21.43;            // total twist over the face, deg
slices = 7;               // twist divisions
shaft_d = 11.84;          // shaft bore
boss_d = 22.9;            // hub diameter
boss_h = 8;               // hub above the face
set_d = 4.5;              // set screw tap hole
set_z = 22;               // set screw height

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
  linear_extrude(height = width, twist = twist, slices = slices) tooth_profile();
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
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = boss_d / 2 + 3, d = set_d);
}
