# Rake::Task["assets:precompile"]
#     .clear_prerequisites
#     .enhance([:environment, "react_on_rails:assets:compile_environment"])
#     .enhance do
#       Rake::Task["react_on_rails:assets:symlink_non_digested_assets"].invoke
#       Rake::Task["react_on_rails:assets:delete_broken_symlinks"].invoke
#     end