$fn = 32;

// ----------------------------------------------------------------------
// Helical gear: m=3 z=18, helix 12 deg, 60 mm x 17 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
module_m = 3;             // normal module
teeth = 18;               // number of teeth
face_w = 12;              // face width
pa = 20;                  // pressure angle, deg
helix = 12;               // helix angle, deg
twist = 5.33;             // total twist over the face, deg
slices = 4;               // twist divisions
bore_d = 6;               // shaft bore
hub_d = 28.8;             // hub diameter
hub_h = 5;                // hub above the face
set_d = 4.5;              // set screw tap hole
set_z = 14.5;             // set screw height

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

module hub_boss() {
  translate([0, 0, face_w - 1]) cylinder(h = hub_h + 1, d = hub_d);
}

difference() {
  union() {
    gear_disc();
    hub_boss();
  }
  translate([0, 0, -1]) cylinder(h = face_w + hub_h + 3, d = bore_d);
  /* set screw, drilled radially */
  translate([-1, 0, set_z]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
}
