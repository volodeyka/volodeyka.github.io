import VersoBlog

open Verso Genre Blog
open Verso.Output.Html

def profileCss : String :=
r#"
.profile-section {
  display: flex;
  gap: 2.5rem;
  align-items: flex-start;
  margin-bottom: 2.5rem;
}
.profile-photo-col {
  flex-shrink: 0;
  max-width: 180px;
}
.profile-photo-col img {
  width: 180px;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}
.profile-caption {
  margin-top: 0.75rem;
  font-size: 0.85rem;
  line-height: 1.5;
}
.profile-caption img {
  height: 1em;
  width: auto;
  vertical-align: middle;
}
.profile-bio {
  flex: 1;
}
@media (max-width: 600px) {
  .profile-section {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
  .profile-photo-col {
    max-width: 140px;
  }
  .profile-photo-col img {
    width: 140px;
  }
}
"#

/--
Renders a profile photo with caption text underneath.
The content of this directive becomes the caption below the photo.
-/
block_component +directive profilePhoto where
  toHtml _id _data _goI goB contents := do
    pure {{
      <div class="profile-photo-col">
        <img src="/static/prof_pic.jpg" alt="Vladimir Gladshtein"/>
        <div class="profile-caption">
          {{← contents.mapM goB}}
        </div>
      </div>
    }}
  cssFiles := #[("profile.css", profileCss)]

/--
Renders a profile bio column, displayed next to the photo.
-/
block_component +directive profileBio where
  toHtml _id _data _goI goB contents := do
    pure {{
      <div class="profile-bio">
        {{← contents.mapM goB}}
      </div>
    }}

def pubEntryCss : String :=
r#"
.pub-entry {
  margin-bottom: 1.75rem;
  padding-left: 1rem;
  border-left: 3px solid #2563eb;
}
.pub-entry p:last-child a {
  display: inline-block;
  padding: 0.2rem 0.65rem;
  border-radius: 6px;
  background: #f0f4ff;
  border: 1px solid #d0daf0;
  font-size: 0.85rem;
  font-weight: 500;
  color: #2563eb;
  transition: all 0.15s;
  text-decoration: none;
  margin-right: 0.25rem;
}
.pub-entry p:last-child a:hover {
  background: #2563eb;
  color: #fff;
  border-color: #2563eb;
}
"#

/--
Renders a publication entry.
-/
block_component +directive pubEntry where
  toHtml _id _data _goI goB contents := do
    pure {{
      <div class="pub-entry">
        {{← contents.mapM goB}}
      </div>
    }}
  cssFiles := #[("pub-entry.css", pubEntryCss)]

def cvEntryCss : String :=
r#"
.cv-entry {
  margin-bottom: 1.25rem;
  padding-left: 1rem;
  border-left: 3px solid #e5e7eb;
}
"#

/--
Renders a CV entry.
-/
block_component +directive cvEntry where
  toHtml _id _data _goI goB contents := do
    pure {{
      <div class="cv-entry">
        {{← contents.mapM goB}}
      </div>
    }}
  cssFiles := #[("cv-entry.css", cvEntryCss)]
