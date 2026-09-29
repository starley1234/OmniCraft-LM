$fn = 32;

// ----------------------------------------------------------------------
// Helical gear: m=1 z=21, helix 18 deg, 23 mm x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
module_m = 1;             // normal module
teeth = 21;               // number of teeth
face_w = 15;              // face width
pa = 20;                  // pressure angle, deg
helix = 18;               // helix angle, deg
twist = 25.71;            // total twist over the face, deg
slices = 9;               // twist divisions
bore_d = 5.92;            // shaft bore
set_d = 4.5;              // set screw tap hole
set_z = 16;               // set screw height

/* --- involute profile --- */
pitch_r = module_m * teeth / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + module_m;
root_r = pitch_r - 1.25 * module_m;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / teeth + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / teeth + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : teeth - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / teeth)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = face_w, twist = twist, slices = slices) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = face_w + 3, d = bore_d);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = (root_r * 0.6), d = set_d);
}
