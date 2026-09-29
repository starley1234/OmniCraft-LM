$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 12 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 80;               // overall length
chamfer = 1;              // end chamfer
groove_r = 6;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 30], [8, 30], [8, 60], [6, 60], [6, 79], [5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
