$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 12, 10 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 20;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 40;                // step 4 length
total = 95;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 57;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [8, 15], [8, 35], [6, 35], [6, 55], [5, 55], [5, 93.5], [3.5, 95], [0, 95]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
