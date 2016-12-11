def pipelines
  <<-PIPELINES
- pipeline: MyAwesomeProject
  stages:
    - spec
    - integration
    - generate_artifacts
- pipeline: MyAwesomeProject_Smoke
  stages:
    - smoke
  PIPELINES
end