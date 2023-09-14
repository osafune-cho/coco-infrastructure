resource "vercel_project" "coco-frontend" {
  name      = "coco-frontend"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = "osafune-cho/coco-frontend"
  }
}

resource "vercel_project_domain" "coco-frontend-vercel-domain" {
  domain     = "coco.osafune-cho.vercel.app"
  project_id = vercel_project.coco-frontend.id
}

resource "vercel_project_domain" "coco-frontend-custom-domain" {
  domain     = "coco.momee.mt"
  project_id = vercel_project.coco-frontend.id
}
